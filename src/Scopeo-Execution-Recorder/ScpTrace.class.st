Class {
	#name : 'ScpTrace',
	#superclass : 'Object',
	#instVars : [
		'previous',
		'next'
	],
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

{ #category : 'accessing' }
ScpTrace >> next [

	^ next
]

{ #category : 'accessing' }
ScpTrace >> next: aNext [

	next := aNext
]

{ #category : 'accessing' }
ScpTrace >> previous [

	^ previous
]

{ #category : 'accessing' }
ScpTrace >> previous: aTask [

	aTask next: self.
	previous := aTask.
]
