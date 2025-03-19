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
		'return',
		'isSuspended',
		'rootInstrumentation'
	],
	#classInstVars : [
		'recorders',
		'methods'
	],
	#category : 'Scopeo-Execution-Recorder',
	#package : 'Scopeo-Execution-Recorder'
}

{ #category : 'as yet unclassified' }
ScpExecutionRecorder class >> disableDebugMode [

	<script: 'self disableDebugMode'>

	methods do: [ :m | 
		self compiler install: m
	]
]

{ #category : 'as yet unclassified' }
ScpExecutionRecorder class >> enableDebugMode [

	<script: 'self enableDebugMode'>

	methods := self methods select: [ :m | m hasPragmaNamed: #debuggerCompleteToSender ].
	methods do: [ :m | 
		self compile: (m ast removePragmaNamed: #debuggerCompleteToSender) formattedCode
	]
]

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

{ #category : 'as yet unclassified' }
ScpExecutionRecorder >> assignment: aNode object: anObject old: anOldValue new: aNewValue default: aDefault [

	execution instruction: (ScpAssignmentTrace new
		node: aNode;
		object: anObject;
		oldValue: anOldValue;
		newValue: aNewValue;
		yourself
	).

	^ aDefault value
]

{ #category : 'accessing' }
ScpExecutionRecorder >> execution [

	^ execution
]

{ #category : 'parameters' }
ScpExecutionRecorder >> execution: aScpExecution [

	execution := aScpExecution
	
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
		reifyNode; reifyObject; reifyOldValue; reifyNewValue; reifyDefault;
		condition: [ :n | n variable isInstanceVariable ];
		handler: self;
		handlerSelector: (self class >> #assignment:object:old:new:default:) selector;
		yourself 
	).
	instrumentation addIndirection: (ScpMessageIndirection new
		reifyNode; reifySender; reifyReceiver; reifyArguments;
		handler: self;
		handlerSelector: (self class >> #message:sender:receiver:arguments:) selector;
		yourself 
	).
	
	rootInstrumentation := ScpMethodInstrumentation new.	
	rootInstrumentation addIndirection: (ScpMethodIndirection new
		reifyMethod; reifyReceiver; reifyArguments;
		handler: self;
		handlerSelector: (self class >> #method:receiver:arguments:) selector;
		yourself
	)

]

{ #category : 'private - execution' }
ScpExecutionRecorder >> instrumentContext [

	| context |

	context := process suspendedContext.
	context
		setSender: context sender 
		receiver: context receiver
		method: (rootInstrumentation applyOn: context method)
		arguments: context arguments

]

{ #category : 'private - execution' }
ScpExecutionRecorder >> isIntrumentableContext [

	| context |

	context := process suspendedContext.
	
	"self haltIf: [ context method isCompiledMethod and: [ context method selector = #new ] ]."
	
	^ context method isCompiledMethod and: [ 
		context method isInstrumented not and: [
		context receiver isPartOfInstrumentation not and: [
			context receiver isBlock not and: [ context willFailReturn not ]
		]
	]
	]
]

{ #category : 'testing' }
ScpExecutionRecorder >> isPartOfInstrumentation [

	^ true
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
				(ignore value: method) ifTrue: [ ^ method ].
			].
		].

	^ self method: method
]

{ #category : 'as yet unclassified' }
ScpExecutionRecorder >> message: aNode sender: aSender receiver: aReceiver arguments: aArguments [

	| method arguments class |

	execution instruction: (ScpMessageTrace new
		node: aNode;
		object: aSender;
		receiver: aReceiver;
		arguments: aArguments;
		yourself
	).

   class := aNode isSuperSend
		ifTrue: [ aNode methodNode methodClass superclass ]
  		ifFalse: [ aReceiver class ].

   method := self lookup: aNode selector in: class.
	method selector = #doesNotUnderstand: ifTrue: [
 		arguments := { (MessageSend
                 receiver: aReceiver
                 selector: aNode selector
                 arguments: aArguments) }
   ].

   ^ self recordMethod: method onReceiver: aReceiver withArguments: aArguments

]

{ #category : 'private - execution' }
ScpExecutionRecorder >> method: aMethod [

	^ methods at: aMethod name ifAbsentPut: [ 
		instrumentation applyOn: aMethod 
	]
]

{ #category : 'as yet unclassified' }
ScpExecutionRecorder >> method: aMethod receiver: aReceiver arguments: aArguments [

	| result |

   result := self
		recordMethod: (self method: aMethod)
  		onReceiver: aReceiver
    	withArguments: aArguments.

   isSuspended := process isSuspended.

   semaphore signal.
   process suspend.

	^ result
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

			self stepToInstrumentableContext.

			process isTerminated ifTrue: [ ^ self ].

			self instrumentContext.
	
			isSuspended ifFalse: [ process resume ].
						
		] doWhileTrue: [ true ]
	] fork
]

{ #category : 'private - recording' }
ScpExecutionRecorder >> recordMethod: aCompiledMethod onReceiver: aReceiver withArguments: aArguments [

   | trace |

   trace := aCompiledMethod isInstrumented 
		ifTrue: [ ScpMethodTrace new ]
		ifFalse: [ ScpMethodUntrackedTrace new ].

   trace node: aCompiledMethod sourceNode.
   trace object: aReceiver.
   trace arguments: aArguments.

   execution method: trace.

   trace result: (aReceiver 
		withArgs: aArguments
  		executeMethod: aCompiledMethod).

   aCompiledMethod isInstrumented ifTrue: [ execution return ].

   ^ trace result
]

{ #category : 'private - execution' }
ScpExecutionRecorder >> stepToInstrumentableContext [
	
	[ process isTerminated or: [ self isIntrumentableContext ] ] whileFalse: [
		process step
   ]
]
