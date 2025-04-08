Class {
	#name : 'ScpExecutionRecordListPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'traceListLabel',
		'traceListPresenter',
		'model'
	],
	#category : 'Scopeo-Execution-Recorder-Presenters',
	#package : 'Scopeo-Execution-Recorder',
	#tag : 'Presenters'
}

{ #category : 'initialization' }
ScpExecutionRecordListPresenter >> defaultLayout [

	^ SpBoxLayout newVertical
		add: traceListLabel height: 20;
		add: traceListPresenter;
		yourself
]

{ #category : 'initialization' }
ScpExecutionRecordListPresenter >> initializePresenters [

	traceListLabel := self newLabel
		label: 'Number of traces: ', model traces size asString;
		yourself.
		
	traceListPresenter := self newList
		items: model traces;
		displayIcon: [ :trace | trace icon ];
		yourself
]

{ #category : 'initialization' }
ScpExecutionRecordListPresenter >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		title: 'Scopeo execution record list presenter';
		initialExtent: 800 @ 500
]

{ #category : 'accessing - model' }
ScpExecutionRecordListPresenter >> setModelBeforeInitialization: aDomainObject [

	model := aDomainObject
]

{ #category : 'accessing' }
ScpExecutionRecordListPresenter >> traceListPresenter [

	^ traceListPresenter
]
