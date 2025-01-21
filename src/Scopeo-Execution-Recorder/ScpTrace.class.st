Class {
	#name : 'ScpTrace',
	#superclass : 'Object',
	#category : 'Scopeo-Execution-Recorder',
	#package : 'Scopeo-Execution-Recorder'
}

{ #category : 'testing' }
ScpTrace class >> isAbstract [

	^ self == ScpTrace
]

{ #category : 'accessing' }
ScpTrace >> yourself [

	"Smalltalk logStdOutDuring: [:logger |
		logger nextPutAll: self asString.
		logger nextPutAll: String crlf
	]."

	^ self
]
