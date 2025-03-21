Class {
	#name : 'ScpExecution',
	#superclass : 'Object',
	#category : 'Scopeo-Execution-Recorder',
	#package : 'Scopeo-Execution-Recorder'
}

{ #category : 'adding' }
ScpExecution >> assignment: aScpAssignmentTrace [

	self subclassResponsibility
]

{ #category : 'adding' }
ScpExecution >> message: aScpMessageTrace [

	self subclassResponsibility
]

{ #category : 'adding' }
ScpExecution >> method: aScpMethodTrace [

	self subclassResponsibility
]

{ #category : 'handling' }
ScpExecution >> pop [

	self subclassResponsibility
]

{ #category : 'debugging actions' }
ScpExecution >> terminate [
]
