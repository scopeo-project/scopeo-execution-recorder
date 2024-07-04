Class {
	#name : 'ScpStateUpdateTrace',
	#superclass : 'ScpTrace',
	#instVars : [
		'object',
		'variable',
		'value'
	],
	#category : 'Scopeo-TraceRecorder-Trace-Model',
	#package : 'Scopeo-TraceRecorder',
	#tag : 'Trace-Model'
}

{ #category : 'accessing' }
ScpStateUpdateTrace class >> fromTraces: aTraces startingAt: anIndex [

	(aTraces at: anIndex) ~~ #assignment ifTrue: [ ^ nil ].

	^ self new
		node: (aTraces at: anIndex + 1);
		variable: (aTraces at: anIndex + 2);
		object: (aTraces at: anIndex + 3);
		value: (aTraces at: anIndex + 4);
		yourself
]

{ #category : 'adding' }
ScpStateUpdateTrace >> addToExecution: anExecution [

	^ anExecution addStateUpdate: self
]

{ #category : 'printing' }
ScpStateUpdateTrace >> asString [

	^ object asString 
		, ': ' , variable asString
		, ' := ' , value asString
]

{ #category : 'testing' }
ScpStateUpdateTrace >> isAssignment [

	^ true
]

{ #category : 'accessing' }
ScpStateUpdateTrace >> object [

	^ object
]

{ #category : 'accessing' }
ScpStateUpdateTrace >> object: anObject [

	object := anObject
]

{ #category : 'accessing' }
ScpStateUpdateTrace >> size [

	^ 4
]

{ #category : 'accessing' }
ScpStateUpdateTrace >> value [

	^ value
]

{ #category : 'accessing' }
ScpStateUpdateTrace >> value: anObject [

	value := anObject
]

{ #category : 'accessing' }
ScpStateUpdateTrace >> variable [

	^ variable
]

{ #category : 'accessing' }
ScpStateUpdateTrace >> variable: anObject [

	variable := anObject
]
