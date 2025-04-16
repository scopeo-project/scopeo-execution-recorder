Class {
	#name : 'ScpTraceChildrenPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'model',
		'labelPresenter',
		'childrenPresenter',
		'iconPresenter'
	],
	#category : 'Scopeo-Execution-Recorder-Presenters',
	#package : 'Scopeo-Execution-Recorder',
	#tag : 'Presenters'
}

{ #category : 'accessing' }
ScpTraceChildrenPresenter >> childrenPresenter [

	^ childrenPresenter
]

{ #category : 'initialization' }
ScpTraceChildrenPresenter >> connectPresenters [

	model children
		ifNotEmpty: [ :children | childrenPresenter items: children ]
		ifEmpty: [
			self layout 
				replaceAtIndex: 2 
				with: (SpBoxLayout newVertical
					add: 'This trace has no children';
					vAlignCenter;
					hAlignCenter;
					yourself)		
		]

]

{ #category : 'layout' }
ScpTraceChildrenPresenter >> defaultLayout [

	^ SpBoxLayout newVertical
		add: (SpBoxLayout newHorizontal
			add: iconPresenter width: 20;
			add: labelPresenter;
			yourself) withConstraints: [ :constraints |
				constraints expand: false.
				constraints padding: 5.
			];
		add: childrenPresenter;
		yourself
]

{ #category : 'initialization' }
ScpTraceChildrenPresenter >> initializePresenters [

	iconPresenter := self newImage
		image: model icon;
		yourself.
	
	labelPresenter := self newLabel
		label: model asString;
		yourself.
		
	childrenPresenter := self newList
		headerTitle: 'Children';
		displayIcon: [ :trace | trace icon ]
		yourself
]

{ #category : 'initialization' }
ScpTraceChildrenPresenter >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		title: 'Scopeo trace children';
		initialExtent: 500 @ 500
]

{ #category : 'accessing - model' }
ScpTraceChildrenPresenter >> setModelBeforeInitialization: aDomainObject [

	model := aDomainObject
]

{ #category : 'enumerating' }
ScpTraceChildrenPresenter >> whenActivatedDo: aBlock [

	childrenPresenter whenActivatedDo: aBlock
]

{ #category : 'enumerating' }
ScpTraceChildrenPresenter >> whenSelectedDo: aBlock [

	childrenPresenter whenSelectedDo: aBlock
]
