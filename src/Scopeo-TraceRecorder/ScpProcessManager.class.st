Class {
	#name : 'ScpProcessManager',
	#superclass : 'Object',
	#instVars : [
		'process',
		'block'
	],
	#category : 'Scopeo-TraceRecorder',
	#package : 'Scopeo-TraceRecorder'
}

{ #category : 'accessing' }
ScpProcessManager >> block: aBlock [

	block := aBlock
]

{ #category : 'accessing' }
ScpProcessManager >> process [

	^ process
]

{ #category : 'accessing' }
ScpProcessManager >> process: anObject [

	process := anObject
]
