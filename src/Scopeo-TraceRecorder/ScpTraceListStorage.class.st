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
ScpTraceListStorage >> method: aSelector sender: aSender receiver: aReceiver arguments: anArguments [

	traces add: (ScpMethodCallTrace new
			 selector: aSelector;
			 receiver: aReceiver;
			 sender: aSender;
			 arguments: anArguments;
			 yourself)
]

{ #category : 'events handling' }
ScpTraceListStorage >> node: aNodeId assignment: aVariable object: anObject value: aValue [

	traces add: (ScpStateUpdateTrace new
			 variable: aVariable;
			 object: anObject;
			 value: aValue;
			 yourself)
]

{ #category : 'events handling' }
ScpTraceListStorage >> node: aNodeId message: aSelector sender: aSender receiver: aReceiver arguments: anArguments [

	traces add: (ScpMethodCallTrace new
			 selector: aSelector;
			 receiver: aReceiver;
			 sender: aSender;
			 arguments: anArguments;
			 yourself)
]

{ #category : 'events handling' }
ScpTraceListStorage >> node: aNodeId return: aValue [

	traces add: (ScpMethodReturnTrace new
			 value: aValue;
			 yourself)
]

{ #category : 'events handling' }
ScpTraceListStorage >> node: aNodeId super: aSelector sender: aSender arguments: anArguments [

	traces add: (ScpSuperMethodCallTrace new
			 selector: aSelector;
			 receiver: aSender;
			 sender: aSender;
			 arguments: anArguments;
			 yourself)
]

{ #category : 'accessing' }
ScpTraceListStorage >> traces [

	^ traces
]
