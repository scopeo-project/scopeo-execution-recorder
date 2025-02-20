Class {
	#name : 'ScpMethod',
	#superclass : 'ScpTrace',
	#instVars : [
		'method',
		'receiver',
		'arguments'
	],
	#category : 'Scopeo-Execution-Recorder',
	#package : 'Scopeo-Execution-Recorder'
}

{ #category : 'accessing' }
ScpMethod >> arguments [

	^ arguments
]

{ #category : 'accessing' }
ScpMethod >> arguments: anObject [

	arguments := anObject
]

{ #category : 'testing' }
ScpMethod >> isMethod [

	^ true
]

{ #category : 'accessing' }
ScpMethod >> method [

	^ method
]

{ #category : 'accessing' }
ScpMethod >> method: anObject [

	method := anObject
]

{ #category : 'accessing' }
ScpMethod >> receiver [

	^ receiver
]

{ #category : 'accessing' }
ScpMethod >> receiver: anObject [

	receiver := anObject
]
