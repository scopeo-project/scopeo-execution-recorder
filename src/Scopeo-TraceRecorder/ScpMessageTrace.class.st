Class {
	#name : 'ScpMessageTrace',
	#superclass : 'ScpTrace',
	#instVars : [
		'selector',
		'sender',
		'receiver',
		'arguments'
	],
	#category : 'Scopeo-TraceRecorder',
	#package : 'Scopeo-TraceRecorder'
}

{ #category : 'accessing' }
ScpMessageTrace >> arguments [

	^ arguments
]

{ #category : 'accessing' }
ScpMessageTrace >> arguments: anObject [

	arguments := anObject
]

{ #category : 'testing' }
ScpMessageTrace >> isMessageToSelf [

	^ false
]

{ #category : 'testing' }
ScpMessageTrace >> isMessageToSuper [

	^ false
]

{ #category : 'printing' }
ScpMessageTrace >> printOn: aStream [

	aStream 
		<< 'Message: '
		<< sender asString << String space
		<< selector asString << String space
		<< receiver asString << String space
		<< arguments asString
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
ScpMessageTrace >> selector [

	^ selector
]

{ #category : 'accessing' }
ScpMessageTrace >> selector: anObject [

	selector := anObject
]

{ #category : 'accessing' }
ScpMessageTrace >> sender [

	^ sender
]

{ #category : 'accessing' }
ScpMessageTrace >> sender: anObject [

	sender := anObject
]
