Class {
	#name : 'ScpMethodUntrackedTrace',
	#superclass : 'ScpMethodTrace',
	#category : 'Scopeo-Execution-Recorder',
	#package : 'Scopeo-Execution-Recorder'
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
