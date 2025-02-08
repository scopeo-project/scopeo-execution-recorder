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
ScpExecutionRecorder >> execute: aSelector in: aClass for: aReceiver with: anArgument [
	
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

{ #category : 'services' }
ScpExecutionRecorder >> forBlock: aBlock [

	self forMethod: (RBMethodNode 
		selector: #DoIt 
		body: aBlock sourceNode body)
		generateMethod.
]

{ #category : 'services' }
ScpExecutionRecorder >> forMethod: aMethod [
	
	| context proc |
	
	context := [ nil executeMethod: aMethod ] asContext.
	semaphore := Semaphore new.
	context privSender: [ 
		semaphore signal.
		Processor terminateRealActive
	] asContext.

	proc := Process 
		forContext: context 
		priority: Processor userInterruptPriority.
	
	[ 
		proc isTerminated or: [ 
			proc suspendedContext method == aMethod 
		] 
	] whileFalse: [ proc step ].

	self forProcess: proc
]

{ #category : 'services' }
ScpExecutionRecorder >> forProcess: aProcess [
	
	| context |
	
	process := aProcess.
	context := process suspendedContext.
	context
		setSender: context sender 
		receiver: context receiver 
		method: (instrumentation applyOn: context method) 
		arguments: context arguments
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

	semaphore 
		ifNil: [ self runAsynchronously ]
		ifNotNil: [ 
			process resume.
			semaphore wait
		]
	
]

{ #category : 'services' }
ScpExecutionRecorder >> runAsynchronously [

	process resume
]

{ #category : 'private' }
ScpExecutionRecorder >> self: aNode sender: aSender arguments: anArguments [

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
