Class {
	#name : 'ScpExecution',
	#superclass : 'Object',
	#instVars : [
		'traces'
	],
	#category : 'Scopeo-Execution-Recorder',
	#package : 'Scopeo-Execution-Recorder'
}

{ #category : 'adding' }
ScpExecution >> add: aTrace [

	traces add: aTrace
]

{ #category : 'initialization' }
ScpExecution >> initialize [

	traces := OrderedCollection new
]

{ #category : 'accessing' }
ScpExecution >> traces [

	^ traces
]
