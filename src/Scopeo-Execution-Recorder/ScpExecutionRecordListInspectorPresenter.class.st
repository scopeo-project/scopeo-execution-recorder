Class {
	#name : 'ScpExecutionRecordListInspectorPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'model',
		'recordListPresenter'
	],
	#category : 'Scopeo-Execution-Recorder-Presenters',
	#package : 'Scopeo-Execution-Recorder',
	#tag : 'Presenters'
}

{ #category : 'as yet unclassified' }
ScpExecutionRecordListInspectorPresenter >> activateOnSingleClick [

	recordListPresenter traceListPresenter activateOnSingleClick
]

{ #category : 'initialization' }
ScpExecutionRecordListInspectorPresenter >> defaultLayout [

	^ SpBoxLayout newVertical
		add: recordListPresenter;
		yourself
]

{ #category : 'initialization' }
ScpExecutionRecordListInspectorPresenter >> initializePresenters [

	recordListPresenter := ScpExecutionRecordListPresenter on: model
]

{ #category : 'as yet unclassified' }
ScpExecutionRecordListInspectorPresenter >> outputActivationPort [

	^ recordListPresenter traceListPresenter outputSelectionPort
]

{ #category : 'accessing - model' }
ScpExecutionRecordListInspectorPresenter >> setModelBeforeInitialization: aDomainObject [

	model := aDomainObject
]
