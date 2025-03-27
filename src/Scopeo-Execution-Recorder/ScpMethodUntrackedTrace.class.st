Class {
	#name : 'ScpMethodUntrackedTrace',
	#superclass : 'ScpMethodTrace',
	#category : 'Scopeo-Execution-Recorder-Traces',
	#package : 'Scopeo-Execution-Recorder',
	#tag : 'Traces'
}

{ #category : 'accessing' }
ScpMethodUntrackedTrace >> icon [

	^ self iconNamed: #remotesManagerEditRemote
]

{ #category : 'testing' }
ScpMethodUntrackedTrace >> isTracked [

	^ false
]

{ #category : 'printing' }
ScpMethodUntrackedTrace >> printOn: aStream [

	aStream << 'MethodUntracked(' << self stringForProperties << ')'
]
