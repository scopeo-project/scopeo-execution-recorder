Class {
	#name : 'ScpExecutionTreePresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'traceTreeLabel',
		'model',
		'traceTreePresenter'
	],
	#category : 'Scopeo-Execution-Recorder',
	#package : 'Scopeo-Execution-Recorder'
}

{ #category : 'api' }
ScpExecutionTreePresenter >> activateOnSingleClick [

	traceTreePresenter activateOnSingleClick 
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
		label: 'Number of methods: ', model methods size asString;
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
