Class {
	#name : 'ScpMethodTrace',
	#superclass : 'ScpInvocationTrace',
	#instVars : [
		'sender',
		'result'
	],
	#category : 'Scopeo-Execution-Recorder',
	#package : 'Scopeo-Execution-Recorder'
}

{ #category : 'testing' }
ScpMethodTrace >> isMethod [

	^ true
]

{ #category : 'testing' }
ScpMethodTrace >> isTracked [

	^ true
]

{ #category : 'printing' }
ScpMethodTrace >> printOn: aStream [

	aStream << 'Method(' << self stringForProperties << ')'
]

{ #category : 'accessing' }
ScpMethodTrace >> receiver [

	^ self object
]

{ #category : 'accessing' }
ScpMethodTrace >> result [

	^ result
]

{ #category : 'accessing' }
ScpMethodTrace >> result: anObject [

	result := anObject
]

{ #category : 'accessing' }
ScpMethodTrace >> sender [

	^ sender
]

{ #category : 'accessing' }
ScpMethodTrace >> sender: anObject [

	sender := anObject
]
