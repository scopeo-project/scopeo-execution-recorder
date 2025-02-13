Class {
	#name : 'ScpTrace',
	#superclass : 'Object',
	#category : 'Scopeo-Execution-Recorder',
	#package : 'Scopeo-Execution-Recorder'
}

{ #category : 'testing' }
ScpTrace class >> isAbstract [

	^ self == ScpTrace
]

{ #category : 'testing' }
ScpTrace >> isAssignment [

	^ false
]

{ #category : 'testing' }
ScpTrace >> isMessage [

	^ false
]
