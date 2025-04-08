Class {
	#name : 'ScpTracePresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'model',
		'codePresenter',
		'detailsPresenter'
	],
	#category : 'Scopeo-Execution-Recorder-Presenters',
	#package : 'Scopeo-Execution-Recorder',
	#tag : 'Presenters'
}

{ #category : 'layout' }
ScpTracePresenter >> defaultLayout [

	^ SpPanedLayout newVertical
		add: detailsPresenter;
		add: codePresenter;
		positionOfSlider: 0.4;
		yourself
]

{ #category : 'initialization' }
ScpTracePresenter >> initializePresenters [ 

	codePresenter := model presenterForCode.
	detailsPresenter := model presenterForDetails
]

{ #category : 'initialization' }
ScpTracePresenter >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		title: 'Scopeo execution record trace presenter';
		initialExtent: 800 @ 500
]

{ #category : 'accessing - model' }
ScpTracePresenter >> setModelBeforeInitialization: aDomainObject [

	model := aDomainObject
]
