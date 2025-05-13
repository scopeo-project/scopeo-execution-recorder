Class {
	#name : 'ScpInvocationTraceDetailsPresenter',
	#superclass : 'ScpTraceDetailsPresenter',
	#instVars : [
		'argumentsListPresenter',
		'argumentsContextMenuGroup'
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
	   add: argumentsListPresenter;
		yourself

]

{ #category : 'initialization' }
ScpInvocationTraceDetailsPresenter >> initializePresenters [

	super initializePresenters.

	argumentsListPresenter := self newList
		headerTitle: 'Arguments';
		contextMenu: (SpMenuPresenter new
			addGroup: [ :group | 
				argumentsContextMenuGroup := group.
				argumentsContextMenuGroup addItem: [ :item | 
					item name: 'Inspect element'; 
					action: [ argumentsListPresenter selectedItem inspect ] 
				]
			]);
		yourself
	

]

{ #category : 'enumerating' }
ScpInvocationTraceDetailsPresenter >> whenSubjectSelectedDo: aBlock [

	super whenSubjectSelectedDo: aBlock.

	argumentsContextMenuGroup addItem: [ :item |
		item name: 'Add to subjects for a future question';
		action: [ aBlock cull: argumentsListPresenter selectedItem ]	
	]
]
