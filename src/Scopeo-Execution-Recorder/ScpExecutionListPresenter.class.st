Class {
	#name : 'ScpExecutionListPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'traceListLabel',
		'traceListPresenter',
		'model'
	],
	#category : 'Scopeo-Execution-Recorder',
	#package : 'Scopeo-Execution-Recorder'
}

{ #category : 'api' }
ScpExecutionListPresenter >> activateOnSingleClick [

	traceListPresenter activateOnSingleClick 
]

{ #category : 'initialization' }
ScpExecutionListPresenter >> defaultLayout [

	^ SpBoxLayout newVertical
		add: traceListLabel height: 20;
		add: traceListPresenter;
		yourself
]

{ #category : 'initialization' }
ScpExecutionListPresenter >> initializePresenters [

	traceListLabel := self newLabel
		label: 'Number of traces: ', model traces size asString;
		yourself.
		
	traceListPresenter := self newList
		items: model traces;
		displayIcon: [ :trace | trace icon ];
		yourself
]

{ #category : 'initialization' }
ScpExecutionListPresenter >> outputActivationPort [

	^ traceListPresenter outputSelectionPort
]

{ #category : 'accessing - model' }
ScpExecutionListPresenter >> setModelBeforeInitialization: aDomainObject [

	model := aDomainObject
]
