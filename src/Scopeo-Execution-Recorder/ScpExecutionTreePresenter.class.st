Class {
	#name : 'ScpExecutionTreePresenter',
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

{ #category : 'api' }
ScpExecutionTreePresenter >> activateOnSingleClick [

	traceTreePresenter activateOnSingleClick 
]

{ #category : 'initialization' }
ScpExecutionTreePresenter >> connectPresenters [

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
ScpExecutionTreePresenter >> defaultLayout [

	^ SpBoxLayout newVertical
		add: traceTreeLabel height: 20;
		add: traceTreePresenter;
		yourself
]

{ #category : 'initialization' }
ScpExecutionTreePresenter >> initializePresenters [

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
ScpExecutionTreePresenter >> outputActivationPort [

	^ traceTreePresenter outputSelectionPort
]

{ #category : 'accessing - model' }
ScpExecutionTreePresenter >> setModelBeforeInitialization: aDomainObject [

	model := aDomainObject
]
