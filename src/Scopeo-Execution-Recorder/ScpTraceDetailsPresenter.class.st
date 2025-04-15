Class {
	#name : 'ScpTraceDetailsPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'model',
		'contextMenuPresenter',
		'detailsTablePresenter',
		'labelPresenter',
		'iconPresenter'
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
		add: (SpBoxLayout newHorizontal
			add: iconPresenter width: 20;
			add: labelPresenter;
			yourself
		) withConstraints: [ :constraints | 
			constraints expand: false.
			constraints padding: 5 
		];
		add: detailsTablePresenter;
		yourself
]

{ #category : 'initialization' }
ScpTraceDetailsPresenter >> initializePresenters [
	
	iconPresenter := self newImage 
		image: model icon;
		yourself.
	
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
