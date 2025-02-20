Class {
	#name : 'ScpAssignment',
	#superclass : 'ScpInstruction',
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
ScpAssignment >> isAssignment [

	^ true

	
]

{ #category : 'accessing' }
ScpAssignment >> newValue [

	^ newValue
]

{ #category : 'accessing' }
ScpAssignment >> newValue: anObject [

	newValue := anObject
]

{ #category : 'accessing' }
ScpAssignment >> object [

	^ object
]

{ #category : 'accessing' }
ScpAssignment >> object: anObject [

	object := anObject
]

{ #category : 'accessing' }
ScpAssignment >> oldValue [

	^ oldValue
]

{ #category : 'accessing' }
ScpAssignment >> oldValue: anObject [

	oldValue := anObject
]

{ #category : 'printing' }
ScpAssignment >> printOn: aStream [

	aStream 
		<< 'Assignment: '
		<< variable asString << String space
		<< object asString << String space
		<< newValue asString
]

{ #category : 'accessing' }
ScpAssignment >> variable [

	^ variable
]

{ #category : 'accessing' }
ScpAssignment >> variable: anObject [

	variable := anObject
]
