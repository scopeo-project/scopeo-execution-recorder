Class {
	#name : 'ScpExternalMethodCallTrace',
	#superclass : 'ScpMethodCallTrace',
	#category : 'Scopeo-TraceRecorder-Trace-Model',
	#package : 'Scopeo-TraceRecorder',
	#tag : 'Trace-Model'
}

{ #category : 'accessing' }
ScpExternalMethodCallTrace class >> fromTraces: aTraces startingAt: anIndex [

	(aTraces at: anIndex) ~~ #externalcall ifTrue: [ ^ nil ].

	^ self new
		selector: (aTraces at: anIndex + 1);
		sender: (aTraces at: anIndex + 2);
		receiver: (aTraces at: anIndex + 3);
		arguments: (aTraces at: anIndex + 4);
		yourself
]

{ #category : 'adding' }
ScpExternalMethodCallTrace >> addToExecution: anExecution [

	^ anExecution addExternalMethodCall: self
]

{ #category : 'testing' }
ScpExternalMethodCallTrace >> isExternalMethodCall [

	^ true
]

{ #category : 'accessing' }
ScpExternalMethodCallTrace >> size [

	^ 4
]
