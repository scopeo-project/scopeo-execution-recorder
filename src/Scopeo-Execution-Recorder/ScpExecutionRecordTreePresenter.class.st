Class {
	#name : 'ScpExecutionRecordTreePresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'traceTreeLabel',
		'model',
		'traceTreePresenter'
	],
	#category : 'Scopeo-Execution-Recorder-Presenters',
	#package : 'Scopeo-Execution-Recorder',
	#tag : 'Presenters'
}

{ #category : 'as yet unclassified' }
ScpExecutionRecordTreePresenter >> connectPresenters [

	traceTreePresenter eventHandler whenKeyDownDo: [ :e |
		| path |
		
		path := traceTreePresenter selection selectedPath.
		e key = KeyboardKey left ifTrue: [ 
			traceTreePresenter collapsePath: path
		].
		e key = KeyboardKey right ifTrue: [ 
			traceTreePresenter expandPath: path
		].
		(e key = KeyboardKey left or: [ e key = KeyboardKey right ]) ifTrue: [
			traceTreePresenter selectPath: path 
		]
	]
]

{ #category : 'initialization' }
ScpExecutionRecordTreePresenter >> defaultLayout [

	^ SpBoxLayout newVertical
		add: traceTreeLabel height: 20;
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

{ #category : 'accessing - model' }
ScpExecutionRecordTreePresenter >> setModelBeforeInitialization: aDomainObject [

	model := aDomainObject
]

{ #category : 'accessing' }
ScpExecutionRecordTreePresenter >> traceTreePresenter [

	^ traceTreePresenter
]
