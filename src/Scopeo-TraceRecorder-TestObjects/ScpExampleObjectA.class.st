Class {
	#name : 'ScpExampleObjectA',
	#superclass : 'ScpExampleObject',
	#instVars : [
		'exampleObjectB'
	],
	#category : 'Scopeo-TraceRecorder-TestObjects',
	#package : 'Scopeo-TraceRecorder-TestObjects'
}

{ #category : 'examples' }
ScpExampleObjectA >> exampleAccessorCall [

	^ exampleObjectB exampleAccessor
]

{ #category : 'as yet unclassified' }
ScpExampleObjectA >> exampleIfTrue [

	| collection |
	collection := OrderedCollection empty.
	collection isEmpty ifTrue: [ ^ true ]
]

{ #category : 'examples' }
ScpExampleObjectA >> exampleMethod [

	exampleObjectB exampleSetter: 'example'.

	[ exampleObjectB exampleSetter: 'exampleInBlock' ] value.

	^ exampleObjectB exampleAccessor
]

{ #category : 'accessing' }
ScpExampleObjectA >> exampleObjectB: anObject [

	exampleObjectB := anObject
]

{ #category : 'examples' }
ScpExampleObjectA >> exampleSetterCall [

	exampleObjectB exampleSetter: 'example'
]

{ #category : 'examples' }
ScpExampleObjectA >> exampleSetterCallInBlock [

	[ exampleObjectB exampleSetter: 'exampleInBlock' ] value
]

{ #category : 'examples' }
ScpExampleObjectA >> exampleSetterCallInBlockInBlock [

	| value |
	value := 'exampleInBlockInBlock'.
	[ :v | [ exampleObjectB exampleSetter: v ] value ] value: value
]

{ #category : 'examples' }
ScpExampleObjectA >> exampleSetterObservableCall [

	 exampleObjectB exampleSetterObservableSlot: 'exampleObservable'
]

{ #category : 'as yet unclassified' }
ScpExampleObjectA >> exampleWithCascade [

	^ self 
		exampleIfTrue; 
		exampleMethod; 
		exampleObjectB: 'test'; 
		yourself.
]
