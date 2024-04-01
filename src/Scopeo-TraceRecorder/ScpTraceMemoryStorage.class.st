Class {
	#name : #ScpTraceMemoryStorage,
	#superclass : #ScpInstrumentationHandler,
	#instVars : [
		'traces'
	],
	#category : #'Scopeo-TraceRecorder-Model'
}

{ #category : #initialization }
ScpTraceMemoryStorage >> initialize [

	traces := OrderedCollection new
]

{ #category : #'events handling' }
ScpTraceMemoryStorage >> onAssignment: aVariable of: anObject value: aValue [

	traces add: (ScpAssignmentTrace new
			 variable: aVariable;
			 object: anObject;
			 value: aValue;
			 yourself)
]

{ #category : #'events handling' }
ScpTraceMemoryStorage >> onMethodCall: aMethodSelector from: aSender to: aReceiver with: aArguments [

	traces add: (ScpMethodCallTrace new
			 selector: aMethodSelector;
			 receiver: aReceiver;
			 sender: aSender;
			 arguments: aArguments;
			 yourself)
]

{ #category : #'events handling' }
ScpTraceMemoryStorage >> onMethodReturn: aValue [

	traces add: (ScpMethodReturnTrace new
			 value: aValue;
			 yourself)
]

{ #category : #'as yet unclassified' }
ScpTraceMemoryStorage >> onSuperCall: aSelector from: aSender with: anArguments [

	traces add: (ScpSuperMethodCallTrace new
			 selector: aSelector;
			 receiver: aSender;
			 sender: aSender;
			 arguments: anArguments;
			 yourself)
]

{ #category : #accessing }
ScpTraceMemoryStorage >> traces [

	^ traces
]
