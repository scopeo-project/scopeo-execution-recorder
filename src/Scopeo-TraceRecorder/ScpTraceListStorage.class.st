Class {
	#name : 'ScpTraceListStorage',
	#superclass : 'ScpInstrumentationHandler',
	#instVars : [
		'traces'
	],
	#category : 'Scopeo-TraceRecorder-Tests',
	#package : 'Scopeo-TraceRecorder',
	#tag : 'Tests'
}

{ #category : 'initialization' }
ScpTraceListStorage >> initialize [

	traces := OrderedCollection new
]

{ #category : 'events handling' }
ScpTraceListStorage >> onAssignment: aVariable of: anObject value: aValue [

	traces add: (ScpAssignmentTrace new
			 variable: aVariable;
			 object: anObject;
			 value: aValue;
			 yourself)
]

{ #category : 'events handling' }
ScpTraceListStorage >> onMethodCall: aMethodSelector from: aSender to: aReceiver with: aArguments [

	traces add: (ScpMethodCallTrace new
			 selector: aMethodSelector;
			 receiver: aReceiver;
			 sender: aSender;
			 arguments: aArguments;
			 yourself)
]

{ #category : 'events handling' }
ScpTraceListStorage >> onMethodReturn: aValue [

	traces add: (ScpMethodReturnTrace new
			 value: aValue;
			 yourself)
]

{ #category : 'as yet unclassified' }
ScpTraceListStorage >> onSuperCall: aSelector from: aSender with: anArguments [

	traces add: (ScpSuperMethodCallTrace new
			 selector: aSelector;
			 receiver: aSender;
			 sender: aSender;
			 arguments: anArguments;
			 yourself)
]

{ #category : 'as yet unclassified' }
ScpTraceListStorage >> traces [

	^ traces
]
