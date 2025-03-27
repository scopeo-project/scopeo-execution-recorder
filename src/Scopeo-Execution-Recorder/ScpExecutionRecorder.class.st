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
		'rootInstrumentation',
		'isDebugged',
		'propagationProcess',
		'isRecording'
	],
	#classInstVars : [
		'recorders',
		'methods'
	],
	#category : 'Scopeo-Execution-Recorder-Recording',
	#package : 'Scopeo-Execution-Recorder',
	#tag : 'Recording'
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
ScpExecutionRecorder class >> recordBlock: aBlock as: aScpExecutionClass [

	^ self recordBlock: aBlock as: aScpExecutionClass ignore: nil 
]

{ #category : 'parameters' }
ScpExecutionRecorder class >> recordBlock: aBlock as: aScpExecutionClass ignore: aIgnoreBlock [

	| recorder process |
	
	<noInstrumentation>
	
	process := Processor activeProcess.
	recorder := self new
			execution: aScpExecutionClass new;
			ignore: aIgnoreBlock;
			process: process;
			yourself.

	recorder startRecording.
	aBlock value.
	recorder stopRecording.
	
	^ recorder execution
]

{ #category : 'as yet unclassified' }
ScpExecutionRecorder >> assignment: aNode object: anObject old: anOldValue new: aNewValue default: aDefault [
	
	execution assignment: (ScpAssignmentTrace new
		node: aNode;
		object: anObject;
		oldValue: anOldValue;
		newValue: aNewValue;
		yourself).

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
		handlerSelector: (self class lookupSelector: #assignment:object:old:new:default:) selector;
		yourself 
	).
	instrumentation addIndirection: (ScpMessageIndirection new
		reifyNode; reifySender; reifyReceiver; reifyArguments;
		handler: self;
		handlerSelector: (self class lookupSelector: #message:sender:receiver:arguments:) selector;
		yourself 
	).
	
	rootInstrumentation := ScpMethodInstrumentation new.	
	rootInstrumentation addIndirection: (ScpMethodIndirection new
		reifyMethod; reifyReceiver; reifyArguments;
		handler: self;
		handlerSelector: (self class lookupSelector: #method:receiver:arguments:) selector;
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
			
			(context method hasPragmaNamed: #noInstrumentation) not and: [  
			context receiver isPartOfInstrumentation not and: [
				context receiver isBlock not and: [ context willFailReturn not ]
			]
		]]
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
	method ifNil: [ 
		method := aClass lookupSelector: #doesNotUnderstand:	
	].

	^ self method: method
]

{ #category : 'as yet unclassified' }
ScpExecutionRecorder >> message: aNode sender: aSender receiver: aReceiver arguments: aArguments [

	| method arguments class |

	execution message: (ScpMessageTrace new
		node: aNode;
		object: aSender;
		receiver: aReceiver;
		arguments: aArguments;
		yourself).

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

	aMethod isInstrumented ifTrue: [ ^ aMethod ].
			"aMethod isPrimitive ifTrue: [ ^ aMethod ]."
			(aMethod pragmaAt: #noInstrumentation) ifNotNil: [ ^ aMethod ].	

			aMethod methodClass = UndefinedObject ifFalse: [ 
				aMethod isFFIMethod ifTrue: [ ^ aMethod ].
				(aMethod package name beginsWith: #Kernel) ifTrue: [ ^ aMethod ].
				(aMethod package name beginsWith: #FreeType) ifTrue: [ ^ aMethod ].
				(aMethod package name beginsWith: #UnifiedFFI) ifTrue: [ ^ aMethod ].
				(aMethod package name beginsWith: #Collection) ifTrue: [ ^ aMethod ].
				(ignore ifNil: [ false ] ifNotNil: [:i | i value: aMethod]) ifTrue: [ ^ aMethod ]
			].

	^ methods at: aMethod name ifAbsentPut: [ 
		instrumentation applyOn: aMethod 
	]
]

{ #category : 'as yet unclassified' }
ScpExecutionRecorder >> method: aMethod receiver: aReceiver arguments: aArguments [

	| result |
	
	[ 	
		result := self
			recordMethod: (self method: aMethod)
  			onReceiver: aReceiver
    		withArguments: aArguments.
		
		execution terminate. 	
	] on: Exception do: [ :e | 
		'Scopeo recorder recorded an exception: ', e asString.
		execution terminate.
		e pass 
	].
	
   propagationProcess isActive ifTrue: [ 
		semaphore signal.
		process suspend
	].

	^ result
]

{ #category : 'accessing' }
ScpExecutionRecorder >> process [

	^ process
]

{ #category : 'parameters' }
ScpExecutionRecorder >> process: aProcess [

	process := aProcess

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
	trace result: (aReceiver withArgs: aArguments executeMethod: aCompiledMethod).
 	execution pop.

   ^ trace result
]

{ #category : 'as yet unclassified' }
ScpExecutionRecorder >> startRecording [
	
	<noInstrumentation>
	
	propagationProcess := [
		[
			semaphore wait.
			self stepToInstrumentableContext.
			process isTerminated ifTrue: [ ^ self ].
			self instrumentContext.
			process resume
		] doWhileTrue: [ true ]
	] fork.

	semaphore signal.
	process suspend
]

{ #category : 'private - execution' }
ScpExecutionRecorder >> stepToInstrumentableContext [
	
	[ process isTerminated or: [ self isIntrumentableContext ] ] whileFalse: [
		process step
   ]
]

{ #category : 'as yet unclassified' }
ScpExecutionRecorder >> stopRecording [

	<noInstrumentation>

	propagationProcess doTerminationFromAnotherProcess 
]
