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
		'methodsPresenter'
	],
	#category : 'Scopeo-Execution-Recorder-Presenters',
	#package : 'Scopeo-Execution-Recorder',
	#tag : 'Presenters'
}

{ #category : 'as yet unclassified' }
ScpExecutionRecordMillerPresenter >> connectPresenter: aPresenter [

	aPresenter whenSelectedDo: [ :selection |
		| index |
		index := traceMillerPresenter pages indexOf: aPresenter.
		traceMillerPresenter resetTo: index.
		traceMillerPresenter addPresenter: (self connectPresenter: selection presenterForChildren).
		traceMillerPresenter selectPage: index + 1
	].

	^ aPresenter
]

{ #category : 'binding' }
ScpExecutionRecordMillerPresenter >> connectPresenters [

	traceTreePresenter eventHandler whenKeyDownDo: [ :e |
		| path |

		path := traceTreePresenter selection selectedPath.
	
		e key = KeyboardKey left ifTrue: [ 
			traceTreePresenter collapsePath: path
		].
	
		e key = KeyboardKey right ifTrue: [ 
			traceTreePresenter expandPath: path.
			traceTreePresenter selectPath: path scrollToSelection: true.
		]
	].

	"traceTreePresenter whenSelectionChangedDo: [ :selection | 
		onTraceSelected ifNotNil: [ :hook | 
			hook value: selection selectedItem 
		]
	]"

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

{ #category : 'accessing' }
ScpExecutionRecordMillerPresenter >> selectTrace: aTrace [

	traceTreePresenter selectItem: aTrace.
	traceTreePresenter withAdapterPerformOrDefer: [ :anAdapter |
		anAdapter scrollToSelection
	]
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
