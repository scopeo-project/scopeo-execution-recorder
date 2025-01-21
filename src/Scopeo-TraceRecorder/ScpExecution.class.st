Class {
	#name : 'ScpExecution',
	#superclass : 'Object',
	#instVars : [
		'traces'
	],
	#category : 'Scopeo-TraceRecorder',
	#package : 'Scopeo-TraceRecorder'
}

{ #category : 'adding' }
ScpExecution >> add: aTrace [

	traces add: aTrace
]

{ #category : 'initialization' }
ScpExecution >> initialize [

	traces := OrderedCollection new
]
