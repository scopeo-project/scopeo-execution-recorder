Class {
	#name : 'ScpExecutionRecord',
	#superclass : 'Object',
	#category : 'Scopeo-Execution-Recorder-Recording',
	#package : 'Scopeo-Execution-Recorder',
	#tag : 'Recording'
}

{ #category : 'adding' }
ScpExecutionRecord >> assignment: aScpAssignmentTrace [

	self subclassResponsibility
]

{ #category : 'adding' }
ScpExecutionRecord >> message: aScpMessageTrace [

	self subclassResponsibility
]

{ #category : 'adding' }
ScpExecutionRecord >> method: aScpMethodTrace [

	self subclassResponsibility
]

{ #category : 'handling' }
ScpExecutionRecord >> pop [

	self subclassResponsibility
]

{ #category : 'presenters' }
ScpExecutionRecord >> presenter [

	self subclassResponsibility
]

{ #category : 'debugging actions' }
ScpExecutionRecord >> terminate [
]
