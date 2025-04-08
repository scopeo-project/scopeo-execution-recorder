Class {
	#name : 'ScpMethodTraceDetailsPresenter',
	#superclass : 'ScpInvocationTraceDetailsPresenter',
	#category : 'Scopeo-Execution-Recorder-Presenters',
	#package : 'Scopeo-Execution-Recorder',
	#tag : 'Presenters'
}

{ #category : 'initialization' }
ScpMethodTraceDetailsPresenter >> connectPresenters [

	super connectPresenters.

	detailsTablePresenter items: { 
		'Method executed' -> model node compiledMethod.
		'Object executing the method' -> model receiver.
		'Result of the method execution' -> model result.
	}.
]

{ #category : 'initialization' }
ScpMethodTraceDetailsPresenter >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		title: 'Scopeo method trace details presenter';
		initialExtent: 500 @ 200
]

{ #category : 'accessing' }
ScpMethodTraceDetailsPresenter >> label [

	^ 'Method trace'
]
