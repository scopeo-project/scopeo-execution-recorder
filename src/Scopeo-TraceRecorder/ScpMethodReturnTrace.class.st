Class {
	#name : 'ScpMethodReturnTrace',
	#superclass : 'ScpTrace',
	#instVars : [
		'value'
	],
	#category : 'Scopeo-TraceRecorder-Trace-Model',
	#package : 'Scopeo-TraceRecorder',
	#tag : 'Trace-Model'
}

{ #category : 'accessing' }
ScpMethodReturnTrace class >> fromTraces: aTraces startingAt: anIndex [

	(aTraces at: anIndex) ~~ #return ifTrue: [ ^ nil ].

	^ self new
		node: (aTraces at: anIndex + 1);
		value: (aTraces at: anIndex + 2);
		yourself
]

{ #category : 'adding' }
ScpMethodReturnTrace >> addToExecution: anExecution [

	^ anExecution addMethodReturn: self
]

{ #category : 'converting' }
ScpMethodReturnTrace >> asString [

	^ 'return ', value asString
]

{ #category : 'testing' }
ScpMethodReturnTrace >> isMethodReturn [

	^ true
]

{ #category : 'accessing' }
ScpMethodReturnTrace >> size [

	^ 2
]

{ #category : 'accessing' }
ScpMethodReturnTrace >> value [

	^ value
]

{ #category : 'accessing' }
ScpMethodReturnTrace >> value: anObject [

	value := anObject
]
