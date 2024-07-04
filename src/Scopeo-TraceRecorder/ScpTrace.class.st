Class {
	#name : 'ScpTrace',
	#superclass : 'Object',
	#instVars : [
		'node'
	],
	#category : 'Scopeo-TraceRecorder-Trace-Model',
	#package : 'Scopeo-TraceRecorder',
	#tag : 'Trace-Model'
}

{ #category : 'accessing' }
ScpTrace class >> fromTraces: aScpIterator startingAt: anIndex [

	^ (self subclasses collect: [ :c | c fromTraces: aScpIterator startingAt: anIndex ])
		detect: [ :t | t isNotNil ]
		ifNone: [ nil ]
]

{ #category : 'testing' }
ScpTrace class >> isAbstract [

	^ self == ScpTrace
]

{ #category : 'adding' }
ScpTrace >> addToExecution: anExecution [

	self subclassResponsibility
]

{ #category : 'testing' }
ScpTrace >> isAssignment [

	^ false
]

{ #category : 'testing' }
ScpTrace >> isMethodCall [

	^ false
]

{ #category : 'testing' }
ScpTrace >> isMethodReturn [

	^ false
]

{ #category : 'accessing' }
ScpTrace >> node [

	^ node
]

{ #category : 'accessing' }
ScpTrace >> node: anObject [

	node := anObject
]

{ #category : 'printing' }
ScpTrace >> printOn: aStream [

	aStream << self asString
]

{ #category : 'accessing' }
ScpTrace >> size [

	self subclassResponsibility
]
