Class {
	#name : 'ScpExecutionRecordVisitor',
	#superclass : 'Object',
	#category : 'Scopeo-Execution-Recorder',
	#package : 'Scopeo-Execution-Recorder'
}

{ #category : 'visiting' }
ScpExecutionRecordVisitor >> visitAssignmentTrace: aScpAssignmentTrace [

	self 
		assert: aScpAssignmentTrace children size <= 1 
		description: 'Inconsistency detected while visiting the record'.

	aScpAssignmentTrace children ifNotEmpty: [ :c | 
		c first accept: self  
	]
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
