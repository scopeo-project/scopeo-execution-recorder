Class {
	#name : 'ScpExecutionRecordTree',
	#superclass : 'ScpExecutionRecord',
	#instVars : [
		'stack',
		'methods',
		'method'
	],
	#category : 'Scopeo-Execution-Recorder-Recording',
	#package : 'Scopeo-Execution-Recorder',
	#tag : 'Recording'
}

{ #category : 'adding' }
ScpExecutionRecordTree >> assignment: aScpAssignmentTrace [

	aScpAssignmentTrace parent: stack top

]

{ #category : 'initialization' }
ScpExecutionRecordTree >> initialize [

	stack := Stack new.
	methods := OrderedCollection new
]

{ #category : 'inspecting' }
ScpExecutionRecordTree >> inspection [
	
	<inspectorPresentationOrder: 1 title: 'Execution tree'>
	
	^ ScpExecutionTreePresenter on: self
]

{ #category : 'adding' }
ScpExecutionRecordTree >> message: aScpMessageTrace [

	aScpMessageTrace parent: stack top

]

{ #category : 'adding' }
ScpExecutionRecordTree >> method: aMethodTrace [

	stack ifNotEmpty: [ :s |
		aMethodTrace parent: s top children last 
	].
	stack push: aMethodTrace
	
]

{ #category : 'accessing' }
ScpExecutionRecordTree >> methods [

	^ methods
]

{ #category : 'accessing' }
ScpExecutionRecordTree >> methods: aCollection [

	methods := aCollection
]

{ #category : 'removing' }
ScpExecutionRecordTree >> pop [

	method := stack pop

]

{ #category : 'debugging actions' }
ScpExecutionRecordTree >> terminate [

	stack 
		ifEmpty: [ methods add: method ]
		ifNotEmpty: [ :s |
			methods add: s last		
		]


]
