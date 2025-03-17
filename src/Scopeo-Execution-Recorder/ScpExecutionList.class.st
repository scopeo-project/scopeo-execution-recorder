Class {
	#name : 'ScpExecutionList',
	#superclass : 'ScpExecution',
	#instVars : [
		'traces'
	],
	#category : 'Scopeo-Execution-Recorder',
	#package : 'Scopeo-Execution-Recorder'
}

{ #category : 'handling' }
ScpExecutionList >> initialize [

	traces := OrderedCollection new
]

{ #category : 'inspecting' }
ScpExecutionList >> inspection [
	
	<inspectorPresentationOrder: 1 title: 'Execution tree'>
	
	^ SpListPresenter new
		items: self traces;
		yourself
]

{ #category : 'adding' }
ScpExecutionList >> instruction: aScpExecutionNode [

	traces add: aScpExecutionNode
]

{ #category : 'adding' }
ScpExecutionList >> method: aScpExecutionNode [

	traces add: aScpExecutionNode
]

{ #category : 'handling' }
ScpExecutionList >> return [

	"Do nothing"
]

{ #category : 'handling' }
ScpExecutionList >> traces [

	^ traces
]
