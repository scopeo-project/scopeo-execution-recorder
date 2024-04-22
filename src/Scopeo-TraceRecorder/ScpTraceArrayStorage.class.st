Class {
	#name : 'ScpTraceArrayStorage',
	#superclass : 'ScpInstrumentationHandler',
	#instVars : [
		'traces',
		'index'
	],
	#category : 'Scopeo-TraceRecorder-Model',
	#package : 'Scopeo-TraceRecorder',
	#tag : 'Model'
}

{ #category : 'initialization' }
ScpTraceArrayStorage >> initialize [

	index := 0.
	traces := OrderedCollection ofSize: 100000
]

{ #category : 'accessing' }
ScpTraceArrayStorage >> nextIndex [

	index := index + 1.
	^ index
]

{ #category : 'events handling' }
ScpTraceArrayStorage >> onAssignment: aVariable of: anObject value: aValue [

	traces at: self nextIndex put: #assignment.
	traces at: self nextIndex put: aVariable.
	traces at: self nextIndex put: anObject.
	traces at: self nextIndex put: aValue
]

{ #category : 'events handling' }
ScpTraceArrayStorage >> onMethodCall: aMethodSelector from: aSender to: aReceiver with: aArguments [

	traces at: self nextIndex put: #call.
	traces at: self nextIndex put: aMethodSelector.
	traces at: self nextIndex put: aSender.
	traces at: self nextIndex put: aReceiver.
	traces at: self nextIndex put: aArguments
]

{ #category : 'events handling' }
ScpTraceArrayStorage >> onMethodReturn: aValue [

	traces at: self nextIndex put: #return.
	traces at: self nextIndex put: aValue 
]

{ #category : 'as yet unclassified' }
ScpTraceArrayStorage >> onSuperCall: aSelector from: aSender with: anArguments [

	traces at: self nextIndex put: #super.
	traces at: self nextIndex put: aSender.
	traces at: self nextIndex put: anArguments 
]

{ #category : 'accessing' }
ScpTraceArrayStorage >> traces [

	^ traces
]
