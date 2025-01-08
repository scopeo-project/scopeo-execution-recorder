Class {
	#name : 'ScopeoTraceRecorder',
	#superclass : 'Object',
	#instVars : [
		'instrumentationForMethod',
		'instrumentationForMessage',
		'instrumentationForAssignment',
		'traces',
		'handler',
		'handlerForAssignment',
		'handlerForMessage',
		'instrumentations'
	],
	#category : 'Scopeo-TraceRecorder',
	#package : 'Scopeo-TraceRecorder'
}

{ #category : 'services' }
ScopeoTraceRecorder class >> traceBlock: aBlock [

 	| recorder method process  |
	
	recorder := self new.
	
	method := recorder trace: (Smalltalk compiler compile: (String streamContents: [:s |
		s nextPutAll: 'scopeo'.
		s nextPutAll: String cr.
		s nextPutAll: aBlock sourceNode body formattedCode.
	])).

	process := [ self 
		withArgs: #() 
		executeMethod: method 
	] newProcess.

	recorder process: process.

	process resume.
	
	recorder reset.
	
	^ recorder
]

{ #category : 'services' }
ScopeoTraceRecorder class >> traceMethod: aMethod inProcess: aProcess [  
		
	^ self new 
		trace: aMethod;
		process: aProcess;
		enable	
	
]

{ #category : 'services' }
ScopeoTraceRecorder class >> traceProcess: aProcess [  
	
	^ self traceMethod: aProcess suspendedContext method inProcess: aProcess
]

{ #category : 'private' }
ScopeoTraceRecorder >> canInstrumentMethod: aMethod [

	aMethod isInstrumented ifTrue: [ ^ false ].

	aMethod methodClass = UndefinedObject ifFalse: [ 
		(aMethod package name beginsWith: #Kernel) ifTrue: [ ^ false ].
		(aMethod package name beginsWith: #Collection) ifTrue: [ ^ false ].
	].
	
	aMethod isPrimitive ifTrue: [ ^ false ].
	(aMethod pragmaAt: #noInstrumentation) ifNotNil: [ ^ false ].
	
	^ true

]

{ #category : 'services' }
ScopeoTraceRecorder >> disable [

	handlerForAssignment disable.
	handlerForMessage disable.
	
]

{ #category : 'services' }
ScopeoTraceRecorder >> enable [

	handlerForAssignment enable.
	handlerForMessage enable
]

{ #category : 'initialization' }
ScopeoTraceRecorder >> initialize [

	
	handlerForAssignment := ScpBeforeHandler new.
	handlerForMessage := ScpBeforeHandler new.

	instrumentations := OrderedCollection new.

	traces := OrderedCollection new.
	
	
]

{ #category : 'private' }
ScopeoTraceRecorder >> instrumentationForAssignment [

	^ instrumentationForAssignment ifNil: [ 
		instrumentationForAssignment := ScpAssignmentInstrumentation new
			handler: handlerForAssignment;
			yourself
	]
]

{ #category : 'private' }
ScopeoTraceRecorder >> instrumentationForMessage [

	^ instrumentationForMessage ifNil: [ 
		instrumentationForMessage := ScpMessageInstrumentation new
			handler: handlerForMessage;
			yourself
	]
]

{ #category : 'services' }
ScopeoTraceRecorder >> isEnabled [

	^ handlerForAssignment isEnabled 
]

{ #category : 'parameters' }
ScopeoTraceRecorder >> process: aProcess [

	handlerForAssignment evaluate: [ :op | 
		thisProcess == aProcess ifTrue: [ 
			traces add: op
		]
	].

	handlerForMessage evaluate: [ :op |
		thisProcess == aProcess ifTrue: [
			"op crTrace."
			self trace: (op receiver class lookupSelector: op selector).
			self halt.
			traces add: op
		]
	]

]

{ #category : 'initialization' }
ScopeoTraceRecorder >> reset [
	self disable.
	instrumentations do: [ :i | 
		i uninstall 
	]
]

{ #category : 'parameters' }
ScopeoTraceRecorder >> trace: aMethod [

	| instrumentation |

	(self canInstrumentMethod: aMethod) ifFalse: [ ^ false ]. 
	
	instrumentation := aMethod instrumentation.
	instrumentation register: self instrumentationForMessage.		
	instrumentation register: self instrumentationForAssignment.
	instrumentation install.
	
	instrumentations add: instrumentation.
	
	^ instrumentation methodModified
]

{ #category : 'services' }
ScopeoTraceRecorder >> traces [

	^ traces
]
