Class {
	#name : 'ScpTraceRecorderHandler',
	#superclass : 'ScpInstrumentationHandler',
	#category : 'Scopeo-TraceRecorder-Model',
	#package : 'Scopeo-TraceRecorder',
	#tag : 'Model'
}

{ #category : 'testing' }
ScpTraceRecorderHandler class >> isAbstract [

	^ self == ScpTraceRecorderHandler
]

{ #category : 'accessing' }
ScpTraceRecorderHandler >> process [

	"Define here the behavior to execute to process the traces."
	self subclassResponsibility
]
