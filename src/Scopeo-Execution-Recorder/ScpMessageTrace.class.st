Class {
	#name : 'ScpMessageTrace',
	#superclass : 'ScpInvocationTrace',
	#instVars : [
		'receiver'
	],
	#category : 'Scopeo-Execution-Recorder',
	#package : 'Scopeo-Execution-Recorder'
}

{ #category : 'accessing' }
ScpMessageTrace >> icon [

	^ self iconNamed: #diveRight
]

{ #category : 'testing' }
ScpMessageTrace >> isMessage [

	^ true
]

{ #category : 'printing' }
ScpMessageTrace >> printOn: aStream [

	aStream << 'Message(' << self stringForProperties << ')'
		
]

{ #category : 'accessing' }
ScpMessageTrace >> receiver [

	^ receiver
]

{ #category : 'accessing' }
ScpMessageTrace >> receiver: anObject [

	receiver := anObject
]

{ #category : 'accessing' }
ScpMessageTrace >> sender [

	^ self object
]
