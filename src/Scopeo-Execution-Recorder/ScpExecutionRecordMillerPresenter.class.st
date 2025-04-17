Class {
	#name : 'ScpExecutionRecordMillerPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'traceTreeLabel',
		'model',
		'traceTreePresenter',
		'onTraceSelected',
		'millerList',
		'traceMillerPresenter',
		'paginatorPresenter',
		'methodsPresenter',
		'selectedPage'
	],
	#category : 'Scopeo-Execution-Recorder-Presenters',
	#package : 'Scopeo-Execution-Recorder',
	#tag : 'Presenters'
}

{ #category : 'as yet unclassified' }
ScpExecutionRecordMillerPresenter >> connectPresenter: aPresenter [

	| presenter |

	self flag: 'To clean'.

	aPresenter whenSelectedDo: [ :selection |
		| index |
		index := traceMillerPresenter pages indexOf: aPresenter.
		traceMillerPresenter resetTo: index.
		traceMillerPresenter addPresenter: (self connectPresenter: selection presenterForChildren).
		selectedPage := index.
		onTraceSelected value: selection
	].


	presenter := (aPresenter isKindOf: ScpTraceChildrenPresenter) 
		ifTrue: [ aPresenter childrenPresenter ] 
		ifFalse: [ aPresenter ].
	
	presenter eventHandler whenKeyDownDo: [ :e |
		e key = KeyboardKey left ifTrue: [ 
			self selectPreviousPage
		].
		e key = KeyboardKey right ifTrue: [
			self selectNextPage		
		]
	].

	^ aPresenter
]

{ #category : 'binding' }
ScpExecutionRecordMillerPresenter >> connectPresenters [

	self connectPresenter: methodsPresenter.
	methodsPresenter items: model methods
]

{ #category : 'initialization' }
ScpExecutionRecordMillerPresenter >> defaultLayout [

	^ SpBoxLayout newVertical
		add: traceTreeLabel withConstraints: [ :constraints |
			constraints expand: false.
			constraints padding: 5
		];
		spacing: 5;
		add: traceMillerPresenter;
		yourself
]

{ #category : 'initialization' }
ScpExecutionRecordMillerPresenter >> initializePresenters [

	traceTreeLabel := self newLabel
		label: 'Number of methods: ', model methods size asString , ', number of traces: ', model traceQuantity asString;
		yourself.

	traceMillerPresenter := SpMillerColumnPresenter new.
	
	methodsPresenter := self newList
		headerTitle: 'Methods';
		displayIcon: [ :trace | trace icon ] 
		yourself.
		
	traceMillerPresenter addPresenter: methodsPresenter 
]

{ #category : 'initialization' }
ScpExecutionRecordMillerPresenter >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		title: 'Scopeo execution record tree presenter';
		initialExtent: 500 @ 400
]

{ #category : 'as yet unclassified' }
ScpExecutionRecordMillerPresenter >> selectNextPage [
	
	self selectPage: selectedPage + 1
]

{ #category : 'api' }
ScpExecutionRecordMillerPresenter >> selectPage: anIndex [

   | presenter |

	self flag: 'To clean'.

   selectedPage := anIndex min: traceMillerPresenter pages size.
   selectedPage := selectedPage max: 1.

   presenter := traceMillerPresenter pages at: selectedPage.
   presenter := (presenter isKindOf: ScpTraceChildrenPresenter)
                   ifTrue: [ presenter childrenPresenter ]
                   ifFalse: [ presenter ].

   presenter takeKeyboardFocus.
	traceMillerPresenter selectPage: selectedPage
]

{ #category : 'as yet unclassified' }
ScpExecutionRecordMillerPresenter >> selectPreviousPage [
	
	self selectPage: selectedPage - 1
]

{ #category : 'accessing' }
ScpExecutionRecordMillerPresenter >> selectTrace: aTrace [

	| chain trace cpt |
	
	self flag: 'To clean'.

	chain := OrderedCollection new.
	
	trace := aTrace.
	
	[ trace isNil ] whileFalse: [ 
		chain addFirst: trace.
		trace := trace parent.
	].

	cpt := 1.
	chain do: [ :t |
		self selectPage: cpt.		
		self selectedPresenter selectItem: t.
		cpt := cpt + 1.
	]
]

{ #category : 'as yet unclassified' }
ScpExecutionRecordMillerPresenter >> selectedPresenter [
	
	| presenter |

	presenter := traceMillerPresenter pages at: selectedPage.
   presenter := (presenter isKindOf: ScpTraceChildrenPresenter)
                   ifTrue: [ presenter childrenPresenter ]
                   ifFalse: [ presenter ].

	^ presenter
]

{ #category : 'accessing - model' }
ScpExecutionRecordMillerPresenter >> setModelBeforeInitialization: aDomainObject [

	model := aDomainObject
]

{ #category : 'accessing' }
ScpExecutionRecordMillerPresenter >> traceTreePresenter [

	"This method exists only to expose the tree presenter to the inspector presenter."

	^ traceTreePresenter
]

{ #category : 'initialization' }
ScpExecutionRecordMillerPresenter >> updatePresenter [

	"1 to: 10 do: [ :index | | presenter |
		presenter := SpListPresenter new
			items: (1 to: index);
			yourself.
		millerList addPresenter: presenter.
		traceTreePresenter addPage: presenter ]."
	"
	traceTreePresenter selectPage: 1.
	millerList selectPage: 1"
]

{ #category : 'event handling' }
ScpExecutionRecordMillerPresenter >> whenSelectedDo: aBlock [

	onTraceSelected := aBlock
]
