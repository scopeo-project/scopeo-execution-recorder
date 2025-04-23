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

{ #category : 'inspector compatibility' }
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

{ #category : 'inspector compatibility' }
ScpExecutionRecordTreeInspectorPresenter >> outputActivationPort [

	^ recordTreePresenter traceTreePresenter outputSelectionPort
]

{ #category : 'accessing' }
ScpExecutionRecordTreeInspectorPresenter >> selectTrace: aScpTrace [

	recordTreePresenter selectTrace: aScpTrace 
]

{ #category : 'accessing - model' }
ScpExecutionRecordTreeInspectorPresenter >> setModelBeforeInitialization: aDomainObject [

	model := aDomainObject
]

{ #category : 'enumerating' }
ScpExecutionRecordTreeInspectorPresenter >> whenSelectedDo: aBlock [

	recordTreePresenter whenSelectedDo: aBlock
]
