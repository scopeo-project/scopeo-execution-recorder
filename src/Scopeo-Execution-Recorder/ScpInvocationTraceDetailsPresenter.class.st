Class {
	#name : 'ScpInvocationTraceDetailsPresenter',
	#superclass : 'ScpTraceDetailsPresenter',
	#instVars : [
		'argumentsListPresenter'
	],
	#category : 'Scopeo-Execution-Recorder-Presenters',
	#package : 'Scopeo-Execution-Recorder',
	#tag : 'Presenters'
}

{ #category : 'testing' }
ScpInvocationTraceDetailsPresenter class >> isAbstract [

	^ self == ScpInvocationTraceDetailsPresenter
]

{ #category : 'initialization' }
ScpInvocationTraceDetailsPresenter >> connectPresenters [

	argumentsListPresenter items: model arguments
]

{ #category : 'layout' }
ScpInvocationTraceDetailsPresenter >> defaultLayout [

	^ SpPanedLayout newVertical
		add: super defaultLayout;
	   add: (SpBoxLayout newVertical 
			add: 'Arguments: ' height: 20;
			add: argumentsListPresenter;
			yourself	
		);
		yourself

]

{ #category : 'as yet unclassified' }
ScpInvocationTraceDetailsPresenter >> initializePresenters [

	super initializePresenters.

	argumentsListPresenter := self newList
		contextMenu: (SpMenuPresenter new
			addGroup: [ :group | 
				group addItem: [ :item | 
					item name: 'Inspect element'; 
					action: [ argumentsListPresenter selectedItem inspect ] 
				]
			]);
		yourself
	

]
