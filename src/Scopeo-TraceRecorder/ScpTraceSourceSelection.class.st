Class {
	#name : 'ScpTraceSourceSelection',
	#superclass : 'Object',
	#instVars : [
		'packages',
		'classes',
		'methods'
	],
	#category : 'Scopeo-TraceRecorder-Model',
	#package : 'Scopeo-TraceRecorder',
	#tag : 'Model'
}

{ #category : 'accessing' }
ScpTraceSourceSelection >> classes [

	^ classes
]

{ #category : 'modifying' }
ScpTraceSourceSelection >> classes: aCollection [

	classes := aCollection asOrderedCollection
]

{ #category : 'initialization' }
ScpTraceSourceSelection >> initialize [

	packages := OrderedCollection empty.
	classes := OrderedCollection empty.
	methods := Dictionary empty
	
]

{ #category : 'accessing' }
ScpTraceSourceSelection >> methodAt: aMethodName [

	^ methods at: aMethodName ifAbsent: [ ^ nil ]
]

{ #category : 'accessing' }
ScpTraceSourceSelection >> methods [

	^ methods values
]

{ #category : 'modifying' }
ScpTraceSourceSelection >> methods: aCollection [

	aCollection asOrderedCollection do: [ :m |
		methods at: m selector put: m
	]
]

{ #category : 'accessing' }
ScpTraceSourceSelection >> packages [

	^ packages
]

{ #category : 'modifying' }
ScpTraceSourceSelection >> packages: aCollection [

	packages := aCollection asOrderedCollection 
]
