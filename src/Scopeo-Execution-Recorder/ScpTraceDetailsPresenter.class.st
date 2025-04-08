Class {
	#name : 'ScpTraceDetailsPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'model',
		'contextMenuPresenter',
		'detailsTablePresenter',
		'labelPresenter'
	],
	#category : 'Scopeo-Execution-Recorder-Presenters',
	#package : 'Scopeo-Execution-Recorder',
	#tag : 'Presenters'
}

{ #category : 'testing' }
ScpTraceDetailsPresenter class >> isAbstract [

	^ self == ScpTraceDetailsPresenter
]

{ #category : 'layout' }
ScpTraceDetailsPresenter >> defaultLayout [

	^ SpBoxLayout newVertical
		add: labelPresenter expand: false;
		add: detailsTablePresenter;
		yourself
]

{ #category : 'initialization' }
ScpTraceDetailsPresenter >> initializePresenters [
	
	labelPresenter := self newLabel label: self label.
	
	detailsTablePresenter := self newTable
		addColumn: (SpStringTableColumn new  
			title: 'Property'; 
			evaluated: [ :each | each key ];
			yourself);
		addColumn: (SpStringTableColumn new  
			title: 'Value'; 
			evaluated: [ :each | StObjectPrinter asTruncatedTextFrom: each value asString ];
			yourself);
		contextMenu: (SpMenuPresenter new
			addGroup: [ :group | 
				group addItem: [ :item | 
					item name: 'Inspect element'; 
					action: [ detailsTablePresenter selectedItem value inspect ] 
				]
			]);
		yourself.
		
	
]

{ #category : 'accessing' }
ScpTraceDetailsPresenter >> label [

	^ self subclassResponsibility
]

{ #category : 'accessing - model' }
ScpTraceDetailsPresenter >> setModelBeforeInitialization: aDomainObject [

	model := aDomainObject
]
