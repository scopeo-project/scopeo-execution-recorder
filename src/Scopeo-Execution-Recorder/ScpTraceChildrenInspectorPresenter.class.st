Class {
	#name : 'ScpTraceChildrenInspectorPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'model',
		'traceChildrenPresenter'
	],
	#category : 'Scopeo-Execution-Recorder-Presenters',
	#package : 'Scopeo-Execution-Recorder',
	#tag : 'Presenters'
}

{ #category : 'api' }
ScpTraceChildrenInspectorPresenter >> activateOnSingleClick [

	traceChildrenPresenter childrenPresenter activateOnSingleClick 
]

{ #category : 'layout' }
ScpTraceChildrenInspectorPresenter >> defaultLayout [

	^ SpBoxLayout newVertical
		add: traceChildrenPresenter;
		yourself
]

{ #category : 'initialization' }
ScpTraceChildrenInspectorPresenter >> initializePresenters [

	traceChildrenPresenter := ScpTraceChildrenPresenter on: model.
]

{ #category : 'transmission' }
ScpTraceChildrenInspectorPresenter >> outputActivationPort [

	^ traceChildrenPresenter childrenPresenter outputSelectionPort
]

{ #category : 'accessing - model' }
ScpTraceChildrenInspectorPresenter >> setModelBeforeInitialization: aDomainObject [

	model := aDomainObject
]
