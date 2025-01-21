Class {
	#name : 'ScpExecutionRecorder',
	#superclass : 'Object',
	#instVars : [
		'execution',
		'context',
		'instrumentation',
		'ignore',
		'methods'
	],
	#category : 'Scopeo-TraceRecorder',
	#package : 'Scopeo-TraceRecorder'
}

{ #category : 'recording' }
ScpExecutionRecorder class >> recordBlock: aBlock [

	^ self new
		recordBlock: aBlock;
		yourself
]

{ #category : 'recording' }
ScpExecutionRecorder class >> recordMethod: aBlock [

	^ self new
		recordMethod: aBlock;
		yourself
]

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

{ #category : 'services' }
ScpExecutionRecorder >> attachToContext: aContext [

	context := aContext.
	context 
		setSender: context sender 
		receiver: context receiver 
		method: (instrumentation applyOn: context method) 
		arguments: context arguments
]

{ #category : 'services' }
ScpExecutionRecorder >> attachToProcess: aProcess [

	self attachToContext: aProcess suspendedContext
]

{ #category : 'accessing' }
ScpExecutionRecorder >> context [

	^ context
]

{ #category : 'accessing' }
ScpExecutionRecorder >> execution [

	^ execution
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
	method ifNil: [ self error: 'Instance of ', aClass, ' did not understand ', aSelector ].		
	
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

	^ aReceiver
		withArgs: anArguments 
		executeMethod: (
			self lookup: aNode selector in: aReceiver class for: aReceiver
		)
]

{ #category : 'services' }
ScpExecutionRecorder >> recordBlock: aBlock [

	self recordMethod: (RBMethodNode 
		selector: #DoIt 
		body: aBlock sourceNode body)
		generateMethod.
]

{ #category : 'services' }
ScpExecutionRecorder >> recordMethod: aMethod [
	
	| process |
	
	process := [ nil executeMethod: aMethod ] newProcess.
	[ 
		process isTerminated or: [ 
			process suspendedContext method == aMethod 
		] 
	] whileFalse: [ process step ].

	self attachToProcess: process.	

	process resume.
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
			
	^ aSender
		withArgs: anArguments 
		executeMethod: (
			self lookup: aNode selector in: aSender class for: aSender
		)
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

	^ aSender 
		withArgs: anArguments 
		executeMethod: (
			self lookup: aNode selector 
				in: aNode methodNode compiledMethod methodClass superclass 
				for: aSender
		)
]
