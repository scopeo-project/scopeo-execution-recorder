Class {
	#name : 'ScpMethodUntrackedTrace',
	#superclass : 'ScpMethodTrace',
	#category : 'Scopeo-Execution-Recorder',
	#package : 'Scopeo-Execution-Recorder'
}

{ #category : 'testing' }
ScpMethodUntrackedTrace >> isTracked [

	^ false
]

{ #category : 'printing' }
ScpMethodUntrackedTrace >> printOn: aStream [

	aStream << 'MethodUntracked(' << self stringForProperties << ')'
]
