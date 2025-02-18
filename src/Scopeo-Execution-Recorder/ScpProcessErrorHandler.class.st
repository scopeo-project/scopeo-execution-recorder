Class {
	#name : 'ScpProcessErrorHandler',
	#superclass : 'Object',
	#category : 'Scopeo-Execution-Recorder',
	#package : 'Scopeo-Execution-Recorder'
}

{ #category : 'error handling' }
ScpProcessErrorHandler >> handleError: anError [

	self halt.
]

{ #category : 'error handling' }
ScpProcessErrorHandler >> handleNotification: aNotification [

	self halt.
]

{ #category : 'error handling' }
ScpProcessErrorHandler >> handleWarning: aWarning [

	self halt.
]
