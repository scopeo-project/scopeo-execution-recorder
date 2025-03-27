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
ScpTrace >> inspection [

	<inspectorPresentationOrder: 1 title: 'Executed node'>
	
	^ SpPresenter new
		layout: (SpBoxLayout newVertical
			add: 'In class: ', self node methodNode methodClass name height: 20;
			add: (	SpCodePresenter new
				beForMethod: self node methodNode;
				text: self node methodNode source;
				addTextSegmentDecoration: (SpTextPresenterDecorator forHighlight
					interval: (self node start to: self node stop + 1);
			 		yourself);
				yourself);
			yourself);
		yourself
	

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
