Class {
	#name : #ScpTrace,
	#superclass : #Object,
	#category : #'Scopeo-TraceRecorder-Model'
}

{ #category : #testing }
ScpTrace class >> isAbstract [

	^ self == ScpTrace
]

{ #category : #testing }
ScpTrace >> isAssignment [

	^ false
]

{ #category : #testing }
ScpTrace >> isMethodCall [

	^ false
]

{ #category : #testing }
ScpTrace >> isMethodReturn [

	^ false
]

{ #category : #printing }
ScpTrace >> printOn: aStream [

	aStream << self asString
]
