Class {
	#name : 'ScpExecutionRecordMillerInspectorPresenter',
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
ScpExecutionRecordMillerInspectorPresenter >> activateOnSingleClick [

	recordTreePresenter traceTreePresenter activateOnSingleClick 
]

{ #category : 'initialization' }
ScpExecutionRecordMillerInspectorPresenter >> defaultLayout [

	^ SpBoxLayout newVertical
		add: recordTreePresenter;
		yourself
]

{ #category : 'initialization' }
ScpExecutionRecordMillerInspectorPresenter >> initializePresenters [

	recordTreePresenter := ScpExecutionRecordMillerPresenter on: model.
]

{ #category : 'inspector compatibility' }
ScpExecutionRecordMillerInspectorPresenter >> outputActivationPort [

	^ recordTreePresenter traceTreePresenter outputSelectionPort
]

{ #category : 'accessing' }
ScpExecutionRecordMillerInspectorPresenter >> selectTrace: aScpTrace [

	recordTreePresenter selectTrace: aScpTrace 
]

{ #category : 'accessing - model' }
ScpExecutionRecordMillerInspectorPresenter >> setModelBeforeInitialization: aDomainObject [

	model := aDomainObject
]

{ #category : 'enumerating' }
ScpExecutionRecordMillerInspectorPresenter >> whenSelectedDo: aBlock [

	recordTreePresenter whenSelectedDo: aBlock
]
