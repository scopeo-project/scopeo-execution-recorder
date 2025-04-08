Class {
	#name : 'ScpMessageTraceDetailsPresenter',
	#superclass : 'ScpInvocationTraceDetailsPresenter',
	#category : 'Scopeo-Execution-Recorder-Presenters',
	#package : 'Scopeo-Execution-Recorder',
	#tag : 'Presenters'
}

{ #category : 'initialization' }
ScpMessageTraceDetailsPresenter >> connectPresenters [

	super connectPresenters.
	
	detailsTablePresenter items: { 
		'Message sender' -> model sender.
		'Message receiver' -> model receiver.
		'Message selector' -> model node selector
	}.
]

{ #category : 'initialization' }
ScpMessageTraceDetailsPresenter >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		title: 'Scopeo message trace details presenter';
		initialExtent: 500 @ 200
]

{ #category : 'accessing' }
ScpMessageTraceDetailsPresenter >> label [

	^ 'Message trace'
]
