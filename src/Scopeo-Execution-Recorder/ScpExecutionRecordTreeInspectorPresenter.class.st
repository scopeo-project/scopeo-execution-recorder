Class {
	#name : 'ScpExecutionRecordTreeInspectorPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'model',
		'recordTreePresenter'
	],
	#category : 'Scopeo-Execution-Recorder-Presenters',
	#package : 'Scopeo-Execution-Recorder',
	#tag : 'Presenters'
}

{ #category : 'as yet unclassified' }
ScpExecutionRecordTreeInspectorPresenter >> activateOnSingleClick [

	recordTreePresenter traceTreePresenter activateOnSingleClick 
]

{ #category : 'initialization' }
ScpExecutionRecordTreeInspectorPresenter >> defaultLayout [

	^ SpBoxLayout newVertical
		add: recordTreePresenter;
		yourself
]

{ #category : 'initialization' }
ScpExecutionRecordTreeInspectorPresenter >> initializePresenters [

	recordTreePresenter := ScpExecutionRecordTreePresenter on: model.
]

{ #category : 'as yet unclassified' }
ScpExecutionRecordTreeInspectorPresenter >> outputActivationPort [

	^ recordTreePresenter traceTreePresenter outputSelectionPort
]

{ #category : 'accessing - model' }
ScpExecutionRecordTreeInspectorPresenter >> setModelBeforeInitialization: aDomainObject [

	model := aDomainObject
]
