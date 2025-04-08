Class {
	#name : 'ScpTraceCodePresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'model',
		'codePresenter',
		'labelPresenter',
		'buttonPresenter'
	],
	#category : 'Scopeo-Execution-Recorder-Presenters',
	#package : 'Scopeo-Execution-Recorder',
	#tag : 'Presenters'
}

{ #category : 'initialization' }
ScpTraceCodePresenter >> connectPresenters [

	buttonPresenter action: [ 
		model node methodNode compiledMethod browse  
	]
]

{ #category : 'layout' }
ScpTraceCodePresenter >> defaultLayout [

	^ SpBoxLayout newVertical
		add: labelPresenter height: 20;
		add: codePresenter;
		add: buttonPresenter expand: false;
		yourself
]

{ #category : 'initialization' }
ScpTraceCodePresenter >> initializePresenters [

	labelPresenter := self newLabel
		label: 'In class: ', model node methodNode methodClass name;
		yourself.

	codePresenter := self newCode
		beForMethod: model node methodNode;
		text: model node methodNode source;
		addTextSegmentDecoration: (SpTextPresenterDecorator forHighlight
			interval: (model node start to: model node stop + 1);
			yourself);
		yourself.
		
	buttonPresenter := self newButton
		label: 'Browse method';
		yourself
]

{ #category : 'initialization' }
ScpTraceCodePresenter >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		title: 'Scopeo execution record trace code presenter';
		initialExtent: 800 @ 500
]

{ #category : 'accessing - model' }
ScpTraceCodePresenter >> setModelBeforeInitialization: aDomainObject [

	model := aDomainObject
]
