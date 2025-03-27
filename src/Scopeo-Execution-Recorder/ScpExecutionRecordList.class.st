Class {
	#name : 'ScpExecutionRecordList',
	#superclass : 'ScpExecutionRecord',
	#instVars : [
		'traces'
	],
	#category : 'Scopeo-Execution-Recorder-Recording',
	#package : 'Scopeo-Execution-Recorder',
	#tag : 'Recording'
}

{ #category : 'adding' }
ScpExecutionRecordList >> assignment: aScpAssignmentTrace [

	traces add: aScpAssignmentTrace
]

{ #category : 'handling' }
ScpExecutionRecordList >> initialize [

	traces := OrderedCollection new
]

{ #category : 'inspecting' }
ScpExecutionRecordList >> inspection [
	
	<inspectorPresentationOrder: 1 title: 'Execution traces'>
	
	^ ScpExecutionListPresenter on: self
	
]

{ #category : 'adding' }
ScpExecutionRecordList >> message: aScpMessageTrace [

	traces add: aScpMessageTrace
]

{ #category : 'adding' }
ScpExecutionRecordList >> method: aScpMethodTrace [

	traces add: aScpMethodTrace
]

{ #category : 'handling' }
ScpExecutionRecordList >> pop [
]

{ #category : 'handling' }
ScpExecutionRecordList >> traces [

	^ traces
]
