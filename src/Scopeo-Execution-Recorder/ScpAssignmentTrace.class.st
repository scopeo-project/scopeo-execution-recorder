Class {
	#name : 'ScpAssignmentTrace',
	#superclass : 'ScpTrace',
	#instVars : [
		'variable',
		'object',
		'oldValue',
		'newValue'
	],
	#category : 'Scopeo-Execution-Recorder',
	#package : 'Scopeo-Execution-Recorder'
}

{ #category : 'testing' }
ScpAssignmentTrace >> isAssignment [

	^ true

	
]

{ #category : 'accessing' }
ScpAssignmentTrace >> newValue [

	^ newValue
]

{ #category : 'accessing' }
ScpAssignmentTrace >> newValue: anObject [

	newValue := anObject
]

{ #category : 'accessing' }
ScpAssignmentTrace >> object [

	^ object
]

{ #category : 'accessing' }
ScpAssignmentTrace >> object: anObject [

	object := anObject
]

{ #category : 'accessing' }
ScpAssignmentTrace >> oldValue [

	^ oldValue
]

{ #category : 'accessing' }
ScpAssignmentTrace >> oldValue: anObject [

	oldValue := anObject
]

{ #category : 'printing' }
ScpAssignmentTrace >> printOn: aStream [

	aStream 
		<< 'Assignment: '
		<< variable asString << String space
		<< object asString << String space
		<< newValue asString
]

{ #category : 'accessing' }
ScpAssignmentTrace >> variable [

	^ variable
]

{ #category : 'accessing' }
ScpAssignmentTrace >> variable: anObject [

	variable := anObject
]
