Class {
	#name : 'ScpAssignmentTraceDetailsPresenter',
	#superclass : 'ScpTraceDetailsPresenter',
	#category : 'Scopeo-Execution-Recorder-Presenters',
	#package : 'Scopeo-Execution-Recorder',
	#tag : 'Presenters'
}

{ #category : 'initialization' }
ScpAssignmentTraceDetailsPresenter >> connectPresenters [

	detailsTablePresenter items: { 
		'Updated object' -> model object.
		'Updated attribute' -> model node variable variable name.
		'Previous attribute value' -> model oldValue.
		'New attribute value' -> model newValue.
	}.
]

{ #category : 'as yet unclassified' }
ScpAssignmentTraceDetailsPresenter >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		title: 'Scopeo assignment trace details presenter';
		initialExtent: 500 @ 200
]

{ #category : 'accessing' }
ScpAssignmentTraceDetailsPresenter >> label [

	^ 'Assignment trace'
]
