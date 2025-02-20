Class {
	#name : 'ScpMessage',
	#superclass : 'ScpInstruction',
	#instVars : [
		'selector',
		'sender',
		'receiver',
		'arguments',
		'result'
	],
	#category : 'Scopeo-Execution-Recorder',
	#package : 'Scopeo-Execution-Recorder'
}

{ #category : 'accessing' }
ScpMessage >> arguments [

	^ arguments
]

{ #category : 'accessing' }
ScpMessage >> arguments: anObject [

	arguments := anObject
]

{ #category : 'testing' }
ScpMessage >> isMessage [

	^ true
]

{ #category : 'testing' }
ScpMessage >> isMessageToSelf [

	^ false
]

{ #category : 'testing' }
ScpMessage >> isMessageToSuper [

	^ false
]

{ #category : 'printing' }
ScpMessage >> printOn: aStream [

	aStream 
		<< 'Message: '
		<< sender asString << String space
		<< selector asString << String space
		<< receiver asString << String space
		<< arguments asString
]

{ #category : 'accessing' }
ScpMessage >> receiver [

	^ receiver
]

{ #category : 'accessing' }
ScpMessage >> receiver: anObject [

	receiver := anObject
]

{ #category : 'accessing' }
ScpMessage >> result [

	^ result
]

{ #category : 'accessing' }
ScpMessage >> result: anObject [

	result := anObject
]

{ #category : 'accessing' }
ScpMessage >> selector [

	^ selector
]

{ #category : 'accessing' }
ScpMessage >> selector: anObject [

	selector := anObject
]

{ #category : 'accessing' }
ScpMessage >> sender [

	^ sender
]

{ #category : 'accessing' }
ScpMessage >> sender: anObject [

	sender := anObject
]
