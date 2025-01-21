Class {
	#name : 'ScpTrace',
	#superclass : 'Object',
	#category : 'Scopeo-TraceRecorder',
	#package : 'Scopeo-TraceRecorder'
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
