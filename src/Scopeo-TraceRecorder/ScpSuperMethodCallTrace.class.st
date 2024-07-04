Class {
	#name : 'ScpSuperMethodCallTrace',
	#superclass : 'ScpMethodCallTrace',
	#category : 'Scopeo-TraceRecorder-Trace-Model',
	#package : 'Scopeo-TraceRecorder',
	#tag : 'Trace-Model'
}

{ #category : 'accessing' }
ScpSuperMethodCallTrace class >> fromTraces: aTraces startingAt: anIndex [

	(aTraces at: anIndex) ~~ #supercall ifTrue: [ ^ nil ].

	^ self new
		node: (aTraces at: anIndex + 1);
		selector: (aTraces at: anIndex + 2);
		sender: (aTraces at: anIndex + 3);
		arguments: (aTraces at: anIndex + 4);
		yourself
]

{ #category : 'adding' }
ScpSuperMethodCallTrace >> addToExecution: anExecution [

	^ anExecution addSuperMethodCall: self
]

{ #category : 'printing' }
ScpSuperMethodCallTrace >> asString [

	^ 'super: ', super asString
]

{ #category : 'testing' }
ScpSuperMethodCallTrace >> isSuperMethodCall [

	^ true
]

{ #category : 'accessing' }
ScpSuperMethodCallTrace >> size [

	^ 4
]
