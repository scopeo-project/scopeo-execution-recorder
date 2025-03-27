Class {
	#name : 'ScpExecutionRecordTree',
	#superclass : 'ScpExecutionRecord',
	#instVars : [
		'stack',
		'methods',
		'method',
		'traceQuantity'
	],
	#category : 'Scopeo-Execution-Recorder-Recording',
	#package : 'Scopeo-Execution-Recorder',
	#tag : 'Recording'
}

{ #category : 'adding' }
ScpExecutionRecordTree >> assignment: aScpAssignmentTrace [

	aScpAssignmentTrace parent: stack top.
	traceQuantity := traceQuantity + 1
]

{ #category : 'initialization' }
ScpExecutionRecordTree >> initialize [

	stack := Stack new.
	methods := OrderedCollection new.
	
	traceQuantity := 0

]

{ #category : 'inspecting' }
ScpExecutionRecordTree >> inspection [
	
	<inspectorPresentationOrder: 1 title: 'Execution tree'>
	
	^ ScpExecutionTreePresenter on: self
]

{ #category : 'adding' }
ScpExecutionRecordTree >> message: aScpMessageTrace [

	aScpMessageTrace parent: stack top.
	traceQuantity := traceQuantity + 1

]

{ #category : 'adding' }
ScpExecutionRecordTree >> method: aMethodTrace [

	stack ifNotEmpty: [ :s |
		aMethodTrace parent: s top children last.
	].
	stack push: aMethodTrace.
	traceQuantity := traceQuantity + 1
	
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

{ #category : 'accessing' }
ScpExecutionRecordTree >> traceQuantity [

	^ traceQuantity
]
