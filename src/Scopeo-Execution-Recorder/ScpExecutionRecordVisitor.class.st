Class {
	#name : 'ScpExecutionRecordVisitor',
	#superclass : 'Object',
	#category : 'Scopeo-Execution-Recorder-Visitors',
	#package : 'Scopeo-Execution-Recorder',
	#tag : 'Visitors'
}

{ #category : 'visiting' }
ScpExecutionRecordVisitor >> visitAssignmentTrace: aScpAssignmentTrace [

	self 
		assert: aScpAssignmentTrace children isEmpty
		description: 'Inconsistency detected while visiting the record'.

	^ aScpAssignmentTrace
]

{ #category : 'visiting' }
ScpExecutionRecordVisitor >> visitExecutionRecord: aScpExecutionRecord [

	aScpExecutionRecord methods do: [ :m |
		m accept: self
	]
]

{ #category : 'visiting' }
ScpExecutionRecordVisitor >> visitMessageTrace: aScpMessageTrace [

	self 
		assert: aScpMessageTrace children size <= 1 
		description: 'Inconsistency detected while visiting the record'.

	aScpMessageTrace children do: [ :m |
		m accept: self
	]
]

{ #category : 'visiting' }
ScpExecutionRecordVisitor >> visitMethodTrace: aScpMethodTrace [

	aScpMethodTrace children do: [ :m |
		m accept: self
	]
]
