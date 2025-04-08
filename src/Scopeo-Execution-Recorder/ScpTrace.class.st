Class {
	#name : 'ScpTrace',
	#superclass : 'Object',
	#instVars : [
		'parent',
		'children',
		'node',
		'object'
	],
	#category : 'Scopeo-Execution-Recorder-Traces',
	#package : 'Scopeo-Execution-Recorder',
	#tag : 'Traces'
}

{ #category : 'testing' }
ScpTrace class >> isAbstract [

	^ self == ScpTrace
]

{ #category : 'visiting' }
ScpTrace >> accept: aScpExecutionRecordVisitor [

	self subclassResponsibility
]

{ #category : 'adding' }
ScpTrace >> addChild: aScpTrace [

	children add: aScpTrace
]

{ #category : 'accessing' }
ScpTrace >> children [

	^ children
]

{ #category : 'accessing' }
ScpTrace >> icon [

	self subclassResponsibility
]

{ #category : 'initialization' }
ScpTrace >> initialize [

	children := OrderedCollection new
]

{ #category : 'inspecting' }
ScpTrace >> inspectorPresenter [

	<inspectorPresentationOrder: 1 title: 'Trace'>
	
	^ self presenter
]

{ #category : 'inspecting' }
ScpTrace >> inspectorPresenterForCode [

	<inspectorPresentationOrder: 2 title: 'Trace node'>
	
	^ self presenterForCode
]

{ #category : 'inspecting' }
ScpTrace >> inspectorPresenterForDetails [

	<inspectorPresentationOrder: 3 title: 'Trace details'>
	
	^ self presenterForDetails
]

{ #category : 'testing' }
ScpTrace >> isAssignment [

	^ false
]

{ #category : 'testing' }
ScpTrace >> isMessage [

	^ false
]

{ #category : 'testing' }
ScpTrace >> isMethod [

	^ false
]

{ #category : 'accessing' }
ScpTrace >> node [

	^ node
]

{ #category : 'accessing' }
ScpTrace >> node: anObject [

	node := anObject
]

{ #category : 'accessing' }
ScpTrace >> object [

	^ object
]

{ #category : 'accessing' }
ScpTrace >> object: anObject [

	object := anObject
]

{ #category : 'accessing' }
ScpTrace >> parent [

	^ parent
]

{ #category : 'accessing' }
ScpTrace >> parent: aScpTrace [

	parent := aScpTrace.
	aScpTrace addChild: self
]

{ #category : 'accessing' }
ScpTrace >> presenter [

	^ ScpTracePresenter on: self
]

{ #category : 'presenters' }
ScpTrace >> presenterForCode [

	^ ScpTraceCodePresenter on: self
]

{ #category : 'presenters' }
ScpTrace >> presenterForDetails [

	^ self subclassResponsibility 
]

{ #category : 'printing' }
ScpTrace >> stringFor: aBlock withDefault: aString [

	| str  |
	
	str := [ aBlock value asString ] onErrorDo: [ ^ aString ].

	str := str copyFrom: 1 to: (str size min: 40).	
	str size = 40 ifTrue: [ 
		str := str , '...'	
	].

	^ str
]
