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
		'semaphore',
		'result',
		'return',
		'isSuspended'
	],
	#classInstVars : [
		'recorders'
	],
	#category : 'Scopeo-Execution-Recorder',
	#package : 'Scopeo-Execution-Recorder'
}

{ #category : 'parameters' }
ScpExecutionRecorder class >> forBlock: aBlock [

	aBlock isClean ifFalse: [
		self error: 'Please use clean blocks only.' 
	].
	
	^ self
		forCode: aBlock sourceNode body formattedCode
		inContext: aBlock outerContext
		onReceiver: aBlock outerContext receiver
]

{ #category : 'private' }
ScpExecutionRecorder class >> forCode: aCode inContext: aContext onReceiver: aReceiver [

	| method methodClass arguments process |

	methodClass := aContext
		ifNil: [ aReceiver class ]
		ifNotNil: [ aContext methodClass ].

	method := methodClass compiler
		source: aCode;
		class: methodClass;
		context: aContext;
		isScripting: true;
		compile.

	arguments := #(  ).
	method numArgs > 0 ifTrue: [
		aContext ifNil: [
			self error:'The method expects arguments, please provide a context from which to extract them.'
		].
		arguments := aContext arguments 
	].

	process := [ 
		method valueWithReceiver: aReceiver arguments: arguments 
	] newProcess.

	[ process suspendedContext method == method ] whileFalse: [ process step ].
	
	^ self forProcess: process
]

{ #category : 'parameters' }
ScpExecutionRecorder class >> forProcess: aProcess [

	^ self recorders at: aProcess ifAbsentPut: [ 
		self new
			process: aProcess;
			yourself
	]
]

{ #category : 'parameters' }
ScpExecutionRecorder class >> recorders [

	^ recorders ifNil: [ recorders := WeakIdentityKeyDictionary new ]
]

{ #category : 'private - execution' }
ScpExecutionRecorder >> executeMessage: aScpMessage [ 
	
	<debuggerCompleteToSender>
	
	| method arguments class |
	
	aScpMessage crTrace.
	
	class := aScpMessage node isSuperSend 
		ifTrue: [ aScpMessage receiver class superclass ]
		ifFalse: [ aScpMessage receiver class ].

	method := self lookup: aScpMessage node selector in: class.
	method selector = #doesNotUnderstand: ifTrue: [
		arguments := { 
			MessageSend 
				receiver: aScpMessage receiver 
				selector: aScpMessage node selector 
				arguments: aScpMessage arguments 
		 }
	].

	^ self recordMethod: method onReceiver: aScpMessage receiver withArguments: aScpMessage arguments 
]

{ #category : 'private - execution' }
ScpExecutionRecorder >> executeMethod: aCompiledMethod onReceiver: aReceiver withArgument: aArguments [

	result := self 
		recordMethod: (self method: aCompiledMethod)
		onReceiver: aReceiver
		withArguments: aArguments.
		
	isSuspended := process isSuspended.
	
	semaphore signal.
	process suspend
]

{ #category : 'accessing' }
ScpExecutionRecorder >> execution [

	^ execution
]

{ #category : 'parameters' }
ScpExecutionRecorder >> execution: aScpExecution [

	execution := aScpExecution
	
]

{ #category : 'private - handling' }
ScpExecutionRecorder >> handleAssignment: anAssignmentOperation [

	<debuggerCompleteToSender>

	self recordAssignment: anAssignmentOperation.

	^ anAssignmentOperation performDefaultOperation
]

{ #category : 'private - handling' }
ScpExecutionRecorder >> handleMessage: aMessageOperation [

	<debuggerCompleteToSender>

	^ self recordMessage: aMessageOperation 
]

{ #category : 'parameters' }
ScpExecutionRecorder >> ignore: aBlock [

	ignore := aBlock
]

{ #category : 'initialization' }
ScpExecutionRecorder >> initialize [

	methods := Dictionary new.
	semaphore := Semaphore new.
	
	ignore := [ :m | false ].
	
	instrumentation := ScpMethodInstrumentation new.
	instrumentation addIndirection: (ScpAssignmentIndirection new
		reifyNode; reifyObject; reifyOldValue; reifyNewValue;
		condition: [ :n | n variable isInstanceVariable ];
		handler: self;
		handlerSelector: #handleAssignment:;
		yourself 
	).
	instrumentation addIndirection: (ScpMessageIndirection new
		reifyNode; reifySender; reifyReceiver; reifyArguments;
		handler: self;
		handlerSelector: #handleMessage:;
		yourself 
	)

]

{ #category : 'private - execution' }
ScpExecutionRecorder >> instrumentContext [

	| context |

	context := process suspendedContext.
	context
		setSender: context sender 
		receiver: self
		method: (self class >> #executeMethod:onReceiver:withArgument:)
		arguments: { context method . context receiver . context arguments }

]

{ #category : 'private - execution' }
ScpExecutionRecorder >> isIntrumentableContext [

	^ process suspendedContext method isCompiledMethod and: [ 
		process suspendedContext receiver isBlock not 
	]
]

{ #category : 'private - execution' }
ScpExecutionRecorder >> lookup: aSelector in: aClass [

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
				(method package name beginsWith: #FreeType) ifTrue: [ ^ method ].
				(method package name beginsWith: #UnifiedFFI) ifTrue: [ ^ method ].
				(method package name beginsWith: #Collection) ifTrue: [ ^ method ].
				(method package name beginsWith: #Scopeo) ifTrue: [ ^ method ].
				(ignore value: method) ifTrue: [ ^ method ].
			].
		].

	^ self method: method
]

{ #category : 'private - execution' }
ScpExecutionRecorder >> method: aMethod [

	^ methods at: aMethod name ifAbsentPut: [ 
		instrumentation applyOn: aMethod 
	]
]

{ #category : 'accessing' }
ScpExecutionRecorder >> process [

	^ process
]

{ #category : 'parameters' }
ScpExecutionRecorder >> process: aProcess [

	process := aProcess.

	process isSuspended ifFalse: [ process suspend ].
	isSuspended := true.

	self stepToInstrumentableContext.

	process isTerminated ifTrue: [ 
		self error: 'Unable to find any valid method in the process execution - process terminated.'
	].	
	
	self instrumentContext.
		
	[
		[
			semaphore wait.

			process 
				return: process suspendedContext 
				value: return.
			
			self stepToInstrumentableContext.
			process isTerminated ifTrue: [ ^ self ].
			self instrumentContext.
	
			isSuspended ifFalse: [ process resume ].
						
		] doWhileTrue: [ true ]
	] fork
]

{ #category : 'private - recording' }
ScpExecutionRecorder >> recordAssignment: aScpAssignment [

	execution instruction: (ScpExecutionNode new
		operation: aScpAssignment;
		yourself
	).
]

{ #category : 'private - recording' }
ScpExecutionRecorder >> recordMessage: aScpMessage [

	| result |

	execution instruction: (ScpExecutionNode new
		operation: aScpMessage;
		yourself
	).
	
	result := (self executeMessage: aScpMessage).

	^ result	
]

{ #category : 'private - recording' }
ScpExecutionRecorder >> recordMethod: aCompiledMethod onReceiver: aReceiver withArguments: aArguments [

	| method |

	method := ScpMethodOperation new.
	method node: aCompiledMethod sourceNode.
	method method: aCompiledMethod original.
	method object: aReceiver.
	method arguments: aArguments.

	execution method: (ScpExecutionNode new 
		recorded: aCompiledMethod isInstrumented;
		operation: method;
		yourself
	).
	aCompiledMethod isInstrumented ifTrue: [ aCompiledMethod name crTrace].
		
	result := aReceiver withArgs: aArguments executeMethod: aCompiledMethod. 
	
	aCompiledMethod isInstrumented ifTrue: [ execution return ].
	
	^ result
]

{ #category : 'private - execution' }
ScpExecutionRecorder >> stepToInstrumentableContext [
	
	[ process isTerminated or: [ self isIntrumentableContext ] ] whileFalse: [
		process step
   ]
]
