Class {
	#name : 'ScpMessageTrace',
	#superclass : 'ScpInvocationTrace',
	#instVars : [
		'receiver'
	],
	#category : 'Scopeo-Execution-Recorder-Traces',
	#package : 'Scopeo-Execution-Recorder',
	#tag : 'Traces'
}

{ #category : 'visiting' }
ScpMessageTrace >> accept: aScpExecutionRecordVisitor [

	^ aScpExecutionRecordVisitor visitMessageTrace: self
]

{ #category : 'accessing' }
ScpMessageTrace >> icon [

	^ self iconNamed: #diveRight
]

{ #category : 'testing' }
ScpMessageTrace >> isMessage [

	^ true
]

{ #category : 'presenters' }
ScpMessageTrace >> presenterForDetails [

	^ ScpMessageTraceDetailsPresenter on: self
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
