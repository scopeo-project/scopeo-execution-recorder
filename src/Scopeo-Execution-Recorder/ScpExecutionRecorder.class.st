"
![TEst](```st self iceRepository```)
"
Class {
	#name : 'ScpExecutionRecorder',
	#superclass : 'Object',
	#instVars : [
		'execution',
		'instrumentation',
		'ignore',
		'methods',
		'process',
		'semaphore'
	],
	#category : 'Scopeo-Execution-Recorder',
	#package : 'Scopeo-Execution-Recorder'
}

{ #category : 'private' }
ScpExecutionRecorder >> assignment: aVariable object: anObject old: anOldValue new: aNewValue [

	<debuggerCompleteToSender>

	execution add: (ScpAssignmentTrace new
		variable: aVariable;
		object: anObject;
		oldValue: anOldValue;
		newValue: aNewValue;
		yourself
	).
	
	aVariable write: aNewValue to: anObject.

	^ aNewValue
]

{ #category : 'private' }
ScpExecutionRecorder >> execute: aMethod for: aReceiver with: anArguments [

	<debuggerCompleteToSender>

	| method result |

	method := aMethod.
	[  
		method isCompiledMethod ifTrue: [ 
			method := instrumentation applyOn: method.
		].

		result := method 
			valueWithReceiver: aReceiver 
			arguments: anArguments.
			
		semaphore signal.
	]
	on: Exception do: [ :e | 
		"Unlock waiting processes in case an exception is not caught earlier."
		semaphore signal.
		e pass.
	].
	
	^ result

]

{ #category : 'private' }
ScpExecutionRecorder >> execute: aSelector in: aClass for: aReceiver with: anArgument [
	
	<debuggerCompleteToSender>
	
	| method arguments |

	arguments := anArgument.
	method := self lookup: aSelector in: aClass for: aReceiver.
	method selector = #doesNotUnderstand: ifTrue: [
		arguments := { 
			MessageSend 
				receiver: aReceiver 
				selector: aSelector 
				arguments: anArgument
		 }
	].

	^ aReceiver 
			withArgs: arguments
			executeMethod: method
]

{ #category : 'accessing' }
ScpExecutionRecorder >> execution [

	^ execution
]

{ #category : 'parameters' }
ScpExecutionRecorder >> forBlock: aBlock [

	aBlock isClean ifFalse: [ 
		self error: 'Please use clean blocks only.'
	].

	self 
		forCode: aBlock sourceNode body formattedCode 
		inContext: aBlock outerContext
		onReceiver: aBlock outerContext receiver
]

{ #category : 'private' }
ScpExecutionRecorder >> forCode: aCode inContext: aContext onReceiver: aReceiver [

	| method methodClass |

	methodClass := aContext 
		ifNil: [ aReceiver class ] 
		ifNotNil: [ aContext methodClass ]. 	

	method := methodClass compiler
		source: aCode;
		class: methodClass;
		context: aContext;
		isScripting: true;
		compile.

	self forMethod: method inContext: aContext onReceiver: aReceiver
]

{ #category : 'parameters' }
ScpExecutionRecorder >> forContext: aContext [

	semaphore := Semaphore new.
	aContext 
		setSender: aContext sender 
		receiver: self
		method: (self class >> #execute:for:with:)
		arguments: { aContext method . aContext receiver . aContext arguments }
]

{ #category : 'private' }
ScpExecutionRecorder >> forMethod: aMethod inContext: aContext onReceiver: aReceiver [
	
	| arguments |

	arguments := #().
	aMethod numArgs > 0 ifTrue: [ 
		aContext ifNil: [ 
			self error: 'The method expects arguments, please provide a context from which to extract them.' 
		].
		arguments := aContext arguments
	].
	
	process := [ 
		aMethod 
			valueWithReceiver: aReceiver
			arguments: arguments.	
	] newProcess.
	
	[ process suspendedContext method == aMethod ] whileFalse: [ 
		process step 
	].

	self forProcess: process
]

{ #category : 'parameters' }
ScpExecutionRecorder >> forProcess: aProcess [

	self forContext: aProcess suspendedContext.
	process := aProcess
]

{ #category : 'parameters' }
ScpExecutionRecorder >> ignore: aBlock [

	ignore := aBlock
]

{ #category : 'initialization' }
ScpExecutionRecorder >> initialize [

	execution := ScpExecution new.
	methods := Dictionary new.
		
	ignore := [ :m | false ].
	
	instrumentation := ScpMethodInstrumentation new.
	instrumentation addIndirection: (ScpAssignmentIndirection new
		condition: [ :n | n variable isInstanceVariable ];
		handler: self;
		selector: #assignment:object:old:new:;
		arguments: #( variable object oldValue newValue );
		yourself 
	).
	instrumentation addIndirection: (ScpMessageIndirection new
		condition: [ :n | n isSelfSend ];
		handler: self;
		selector: #self:sender:arguments:;
		arguments: #( node sender arguments );
		yourself 
	).
	instrumentation addIndirection: (ScpMessageIndirection new
		condition: [ :n | n isSuperSend ];
		handler: self;
		selector: #super:sender:arguments:;
		arguments: #( node sender arguments );
		yourself 
	).
	instrumentation addIndirection: (ScpMessageIndirection new
		condition: [ :n | (n isSelfSend or: [ n isSuperSend ]) not ];
		handler: self;
		selector: #message:sender:receiver:arguments:;
		arguments: #( node sender receiver arguments );
		yourself 
	).

]

{ #category : 'private' }
ScpExecutionRecorder >> lookup: aSelector in: aClass for: aReceiver [

	| method |
		
	method := aClass lookupSelector: aSelector. 
	method 
		ifNil: [ 
			method := aClass lookupSelector: #doesNotUnderstand:.	
		] 
		ifNotNil: [ 
			method isInstrumented ifTrue: [ ^ method ].
			method isPrimitive ifTrue: [ ^ method ].
			(method pragmaAt: #noInstrumentation) ifNotNil: [ ^ method ].	

			method methodClass = UndefinedObject ifFalse: [ 
				(method package name beginsWith: #Kernel) ifTrue: [ ^ method ].
				(method package name beginsWith: #UnifiedFFI) ifTrue: [ ^ method ].
				(method package name beginsWith: #Collection) ifTrue: [ ^ method ].
				(method package name beginsWith: #Scopeo) ifTrue: [ ^ method ].
				(ignore value: method) ifTrue: [ ^ method ].
			].
		].

	^ methods at: method name ifAbsentPut: [ 
		instrumentation applyOn: method 
	]
]

{ #category : 'private' }
ScpExecutionRecorder >> message: aNode sender: aSender receiver: aReceiver arguments: anArguments [

	<debuggerCompleteToSender>

	execution add: (ScpMessageTrace new
		selector: aNode selector;
		sender: aSender;
		receiver: aReceiver;
		arguments: anArguments;
		yourself
	).	

	^ self 
		execute: aNode selector 
		in: aReceiver class 
		for: aReceiver 
		with: anArguments
]

{ #category : 'accessing' }
ScpExecutionRecorder >> process [

	^ process
]

{ #category : 'services' }
ScpExecutionRecorder >> run [

	process resume.
	semaphore wait.
]

{ #category : 'services' }
ScpExecutionRecorder >> runAsynchronously [

	process resume
]

{ #category : 'private' }
ScpExecutionRecorder >> self: aNode sender: aSender arguments: anArguments [

	<debuggerCompleteToSender>

	execution add: (ScpMessageToSelfTrace new
		selector: aNode selector;
		sender: aSender;
		receiver: aSender;
		arguments: anArguments;
		yourself
	).	

	^ self 
		execute: aNode selector 
		in: aSender class 
		for: aSender 
		with: anArguments
]

{ #category : 'private' }
ScpExecutionRecorder >> super: aNode sender: aSender arguments: anArguments [

	<debuggerCompleteToSender>

	execution add: (ScpMessageToSuperTrace new
		selector: aNode selector;
		sender: aSender;
		receiver: aSender;
		arguments: anArguments;
		yourself
	).

	^ self 
		execute: aNode selector 
		in: aNode methodNode compiledMethod methodClass superclass
		for: aSender 
		with: anArguments
]
