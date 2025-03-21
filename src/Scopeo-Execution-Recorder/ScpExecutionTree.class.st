Class {
	#name : 'ScpExecutionTree',
	#superclass : 'ScpExecution',
	#instVars : [
		'stack',
		'methods',
		'method'
	],
	#category : 'Scopeo-Execution-Recorder',
	#package : 'Scopeo-Execution-Recorder'
}

{ #category : 'adding' }
ScpExecutionTree >> assignment: aScpAssignmentTrace [

	aScpAssignmentTrace parent: stack top

]

{ #category : 'initialization' }
ScpExecutionTree >> initialize [

	stack := Stack new.
	methods := OrderedCollection new
]

{ #category : 'inspecting' }
ScpExecutionTree >> inspection [
	
	<inspectorPresentationOrder: 1 title: 'Execution tree'>
	
	^ ScpExecutionTreePresenter on: self
]

{ #category : 'adding' }
ScpExecutionTree >> message: aScpMessageTrace [

	aScpMessageTrace parent: stack top

]

{ #category : 'adding' }
ScpExecutionTree >> method: aMethodTrace [

	stack ifNotEmpty: [ :s |
		aMethodTrace parent: s top children last 
	].
	stack push: aMethodTrace
	
]

{ #category : 'accessing' }
ScpExecutionTree >> methods [

	^ methods
]

{ #category : 'accessing' }
ScpExecutionTree >> methods: aCollection [

	methods := aCollection
]

{ #category : 'removing' }
ScpExecutionTree >> pop [

	method := stack pop

]

{ #category : 'debugging actions' }
ScpExecutionTree >> terminate [

	methods add: stack last
]
