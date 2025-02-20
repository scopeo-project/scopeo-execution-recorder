Class {
	#name : 'ScpRoot',
	#superclass : 'ScpTrace',
	#category : 'Scopeo-Execution-Recorder',
	#package : 'Scopeo-Execution-Recorder'
}

{ #category : 'testing' }
ScpRoot >> isRoot [

	^ true
]

{ #category : 'accessing' }
ScpRoot >> parent [

	self error: 'This node is the root of the execution, it has no parent.'
]
