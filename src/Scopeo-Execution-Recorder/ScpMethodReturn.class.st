Class {
	#name : 'ScpMethodReturn',
	#superclass : 'ScpTrace',
	#category : 'Scopeo-Execution-Recorder-Traces',
	#package : 'Scopeo-Execution-Recorder',
	#tag : 'Traces'
}

{ #category : 'accessing' }
ScpMethodReturn >> icon [

	^ self iconNamed: #leftArrow
]

{ #category : 'testing' }
ScpMethodReturn >> isReturn [

	^ true
]
