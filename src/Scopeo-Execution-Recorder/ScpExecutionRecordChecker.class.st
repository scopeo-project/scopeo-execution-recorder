Class {
	#name : 'ScpExecutionRecordChecker',
	#superclass : 'ScpExecutionRecordVisitor',
	#instVars : [
		'method',
		'methods'
	],
	#category : 'Scopeo-Execution-Recorder',
	#package : 'Scopeo-Execution-Recorder'
}

{ #category : 'validation' }
ScpExecutionRecordChecker class >> check: aScpExecutionRecord [

	self new visitExecutionRecord: aScpExecutionRecord.
	
	^ true
]

{ #category : 'visiting' }
ScpExecutionRecordChecker >> visitAssignmentTrace: anAssignmentTrace [

	| methodOrBlock |
	
	methodOrBlock := anAssignmentTrace node parent methodOrBlockNode.
	methodOrBlock isBlock ifTrue: [ ^ self ].

	self
		assert: (methods top assignmentNodes includes: anAssignmentTrace node)
		description: 'Assignment ' 
			, anAssignmentTrace node asString
			, ' attached to the wrong method trace ' 
			, methods top methodClass name, ' >> #'
			, methods top selector
]

{ #category : 'visiting' }
ScpExecutionRecordChecker >> visitMessageTrace: aMessageTrace [
	
	| methodOrBlock |
	
	methodOrBlock := aMessageTrace node parent methodOrBlockNode.
	methodOrBlock isBlock ifTrue: [ ^ self ].
	self
		assert: (methods top sendNodes includes: aMessageTrace node)
		description: 'Message ' 
			, aMessageTrace node asString
			, ' attached to the wrong method trace ' 
			, methods top methodClass name, ' >> #'
			, methods top selector
]
