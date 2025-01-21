Class {
	#name : 'ScpExecutionRecorder',
	#superclass : 'Object',
	#instVars : [
		'execution',
		'methods',
		'instrumentation',
		'process',
		'context'
	],
	#category : 'Scopeo-TraceRecorder',
	#package : 'Scopeo-TraceRecorder'
}

{ #category : 'as yet unclassified' }
ScpExecutionRecorder class >> attachToContext: aContext [

	^ self new 
		record: aContext;
		yourself
]

{ #category : 'as yet unclassified' }
ScpExecutionRecorder class >> attachToProcess: aProcess [

	^ self attachToContext: aProcess suspendedContext
]

{ #category : 'as yet unclassified' }
ScpExecutionRecorder class >> recordBlock: aBlock [

	^ self recordMethod: (RBMethodNode 
		selector: #DoIt 
		body: aBlock sourceNode body)
		generateMethod.
]

{ #category : 'as yet unclassified' }
ScpExecutionRecorder class >> recordMethod: aMethod [
	
	| process recorder |
	
	process := [ nil executeMethod: aMethod ] newProcess.
	[ 
		process isTerminated or: [ 
			process suspendedContext method == aMethod 
		] 
	] whileFalse: [ process step ].

	recorder := self attachToProcess: process.	
	process resume.

	^ recorder
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

{ #category : 'accessing' }
ScpExecutionRecorder >> context [

	^ context
]

{ #category : 'accessing' }
ScpExecutionRecorder >> execution [

	^ execution
]

{ #category : 'initialization' }
ScpExecutionRecorder >> initialize [

	execution := ScpExecution new.

	methods := Dictionary new.

	instrumentation := ScpMethodInstrumentation new.
	instrumentation addIndirection: (ScpAssignmentIndirection new
		condition: [ :n | n isInstanceVariable ];
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
ScpExecutionRecorder >> instrument: aMethod [

	aMethod isInstrumented ifTrue: [ ^ aMethod ].

	aMethod methodClass = UndefinedObject ifFalse: [ 
		(aMethod package name beginsWith: #Scopeo) ifTrue: [ ^ aMethod ].
		(aMethod package name beginsWith: #UnifiedFFI) ifTrue: [ ^ aMethod ].
		(aMethod package name beginsWith: #Morphic) ifTrue: [ ^ aMethod ].
		(aMethod package name beginsWith: #Kernel) ifTrue: [ ^ aMethod ].
		(aMethod package name beginsWith: #Collection) ifTrue: [ ^ aMethod ].
	].
	
	aMethod isPrimitive ifTrue: [ ^ aMethod ].
	(aMethod pragmaAt: #noInstrumentation) ifNotNil: [ ^ aMethod ].

	^ methods at: aMethod name ifAbsentPut: [ 
		instrumentation applyOn: aMethod 
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
			self instrument: (
				aReceiver class 
					lookupSelector: aNode selector
			)
		)
]

{ #category : 'actions api' }
ScpExecutionRecorder >> record: aContext [
	
	context := aContext.
	context 
		setSender: context sender 
		receiver: context receiver 
		method: (instrumentation applyOn: context method) 
		arguments: context arguments

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
			self instrument: (
				aSender class 
					lookupSelector: aNode selector
			)
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
			self instrument: (
				aNode methodNode compiledMethod 
					methodClass superclass
					lookupSelector: aNode selector
			)
		)
]
