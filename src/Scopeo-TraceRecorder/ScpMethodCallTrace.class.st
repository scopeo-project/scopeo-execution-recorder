Class {
	#name : 'ScpMethodCallTrace',
	#superclass : 'ScpTrace',
	#instVars : [
		'sender',
		'selector',
		'receiver',
		'arguments'
	],
	#category : 'Scopeo-TraceRecorder-Trace-Model',
	#package : 'Scopeo-TraceRecorder',
	#tag : 'Trace-Model'
}

{ #category : 'accessing' }
ScpMethodCallTrace class >> fromTraces: aTraces startingAt: anIndex [

	^ (super fromTraces: aTraces startingAt: anIndex)
		ifNil: [  
			(aTraces at: anIndex) ~~ #call ifTrue: [ ^ nil ].

			self new
				node: (aTraces at: anIndex + 1);
				selector: (aTraces at: anIndex + 2);
				sender: (aTraces at: anIndex + 3);
				receiver: (aTraces at: anIndex + 4);
				arguments: (aTraces at: anIndex + 5);
				yourself
		]
]

{ #category : 'adding' }
ScpMethodCallTrace >> addToExecution: anExecution [

	^ anExecution addMethodCall: self
]

{ #category : 'accessing' }
ScpMethodCallTrace >> arguments [

	^ arguments
]

{ #category : 'accessing' }
ScpMethodCallTrace >> arguments: anObject [

	arguments := anObject
]

{ #category : 'printing' }
ScpMethodCallTrace >> asString [

	^ sender asString 
		, ' sent ', selector asString
		, ' to ', receiver asString 
		, ' with ', arguments asString
]

{ #category : 'testing' }
ScpMethodCallTrace >> isExternalMethodCall [

	^ false
]

{ #category : 'testing' }
ScpMethodCallTrace >> isMethodCall [

	^ true
]

{ #category : 'testing' }
ScpMethodCallTrace >> isSuperMethodCall [

	^ false
]

{ #category : 'accessing' }
ScpMethodCallTrace >> receiver [

	^ receiver
]

{ #category : 'accessing' }
ScpMethodCallTrace >> receiver: anObject [

	receiver := anObject
]

{ #category : 'accessing' }
ScpMethodCallTrace >> selector [

	^ selector
]

{ #category : 'accessing' }
ScpMethodCallTrace >> selector: anObject [

	selector := anObject
]

{ #category : 'accessing' }
ScpMethodCallTrace >> sender [

	^ sender
]

{ #category : 'accessing' }
ScpMethodCallTrace >> sender: anObject [

	sender := anObject
]

{ #category : 'accessing' }
ScpMethodCallTrace >> size [

	^ 5
]
