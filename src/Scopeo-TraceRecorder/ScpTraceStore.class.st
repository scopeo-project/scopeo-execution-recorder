Class {
	#name : 'ScpTraceStore',
	#superclass : 'ScpInstrumentationHandler',
	#instVars : [
		'store',
		'index',
		'methodIndex'
	],
	#category : 'Scopeo-TraceRecorder-Model',
	#package : 'Scopeo-TraceRecorder',
	#tag : 'Model'
}

{ #category : 'initialization' }
ScpTraceStore >> initialize [

	index := 0.
	store := ScpStore new
]

{ #category : 'events handling' }
ScpTraceStore >> onAssignment: aVariable of: anObject value: aValue [

	index := index + 1.
	
	store subject: anObject hash predicate: #type object: #object.
	store subject: anObject hash predicate: #class object: anObject class.
	
	store subject: aValue hash predicate: #type object: #object.
	store subject: aValue hash predicate: #class object: anObject class.
	store subject: aValue hash predicate: #object object: aValue.
	
	store subject: index predicate: #type object: #assignment.
	store subject: index predicate: #object object: anObject hash.
	store subject: index predicate: #variable object: aVariable.	
	store subject: index predicate: #value object: aValue hash.	
	store subject: index predicate: #methodcall object: methodIndex.
	
	
]

{ #category : 'accessing' }
ScpTraceStore >> onMethodCall: aMethodSelector from: aSender to: aReceiver with: aArguments [

	index := index + 1.
	
	store subject: aSender hash predicate: #type object: #object. 
	store subject: aSender hash predicate: #class object: aSender class.
	
	store subject: aReceiver hash predicate: #type object: #object. 
	store subject: aReceiver hash predicate: #class object: aReceiver class.
	
	store subject: index predicate: #type object: #methodcall.
	store subject: index predicate: #super object: false.
	store subject: index predicate: #sender object: aSender hash.
	store subject: index predicate: #receiver object: aReceiver hash.
	store subject: index predicate: #selector object: aMethodSelector.
	aArguments do: [ :a | 
		store subject: index predicate: #argument object: a.			
	].
	
	methodIndex := index
]

{ #category : 'accessing' }
ScpTraceStore >> onMethodReturn: aValue [

	index := index + 1.

	store subject: index predicate: #type object: #return.
	store subject: index predicate: #methodcall object: methodIndex.	
	store subject: index predicate: #value object: aValue.	
]

{ #category : 'events handling' }
ScpTraceStore >> onSuperCall: aMethodSelector from: aSender with: aArguments [

	index := index + 1.
	
	store subject: aSender hash predicate: #type object: #object. 
	store subject: aSender hash predicate: #class object: aSender class.

	
	store subject: index predicate: #type object: #methodcall.
	store subject: index predicate: #super object: true.
	store subject: index predicate: #sender object: aSender hash.
	store subject: index predicate: #selector object: aMethodSelector.
	aArguments arguments do: [ :a | 
		store subject: index predicate: #argument object: a.			
	].
]

{ #category : 'accessing' }
ScpTraceStore >> store [

	^ store
]
