Class {
	#name : 'ScpExecutionRecordTreePresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'traceTreeLabel',
		'model',
		'traceTreePresenter',
		'onTraceSelected'
	],
	#category : 'Scopeo-Execution-Recorder-Presenters',
	#package : 'Scopeo-Execution-Recorder',
	#tag : 'Presenters'
}

{ #category : 'binding' }
ScpExecutionRecordTreePresenter >> connectPresenters [

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

	traceTreePresenter whenSelectionChangedDo: [ :selection | 
		onTraceSelected ifNotNil: [ :hook | 
			hook value: selection selectedItem 
		]
	]
]

{ #category : 'initialization' }
ScpExecutionRecordTreePresenter >> defaultLayout [

	^ SpBoxLayout newVertical
		add: traceTreeLabel withConstraints: [ :constraints |
			constraints expand: false.
			constraints padding: 5
		];
		add: traceTreePresenter;
		yourself
]

{ #category : 'initialization' }
ScpExecutionRecordTreePresenter >> initializePresenters [

	traceTreeLabel := self newLabel
		label: 'Number of methods: ', model methods size asString , ', number of traces: ', model traceQuantity asString;
		yourself.
			
	traceTreePresenter := self newTree
		roots: model methods;
		children: [ :node | node children ];
		display: [ :node | node asString ];
		displayIcon: [ :node | node icon ];
		beSingleSelection;
		expandRoots;
		yourself
]

{ #category : 'initialization' }
ScpExecutionRecordTreePresenter >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		title: 'Scopeo execution record tree presenter';
		initialExtent: 800 @ 500
]

{ #category : 'accessing' }
ScpExecutionRecordTreePresenter >> selectTrace: aTrace [

	traceTreePresenter selectItem: aTrace.
	traceTreePresenter withAdapterPerformOrDefer: [ :anAdapter |
		anAdapter scrollToSelection
	]
]

{ #category : 'accessing - model' }
ScpExecutionRecordTreePresenter >> setModelBeforeInitialization: aDomainObject [

	model := aDomainObject
]

{ #category : 'accessing' }
ScpExecutionRecordTreePresenter >> traceTreePresenter [

	"This method exists onlye to expose the tree presenter to the inspector presenter."

	^ traceTreePresenter
]

{ #category : 'event handling' }
ScpExecutionRecordTreePresenter >> whenSelectedDo: aBlock [

	onTraceSelected := aBlock
]
