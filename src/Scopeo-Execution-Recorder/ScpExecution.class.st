Class {
	#name : 'ScpExecution',
	#superclass : 'Object',
	#category : 'Scopeo-Execution-Recorder',
	#package : 'Scopeo-Execution-Recorder'
}

{ #category : 'adding' }
ScpExecution >> instruction: aScpExecutionNode [

	self subclassResponsibility
]

{ #category : 'adding' }
ScpExecution >> method: aScpExecutionNode [

	self subclassResponsibility
]

{ #category : 'handling' }
ScpExecution >> return [

	self subclassResponsibility
]
