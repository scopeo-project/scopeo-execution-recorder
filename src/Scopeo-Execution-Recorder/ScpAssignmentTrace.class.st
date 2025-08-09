Class {
	#name : 'ScpAssignmentTrace',
	#superclass : 'ScpTrace',
	#instVars : [
		'oldValue',
		'newValue'
	],
	#category : 'Scopeo-Execution-Recorder-Traces',
	#package : 'Scopeo-Execution-Recorder',
	#tag : 'Traces'
}

{ #category : 'visiting' }
ScpAssignmentTrace >> accept: aScpExecutionRecordVisitor [

	^ aScpExecutionRecordVisitor visitAssignmentTrace: self
]

{ #category : 'accessing' }
ScpAssignmentTrace >> icon [

	^ self iconNamed: #changeUpdate
]

{ #category : 'testing' }
ScpAssignmentTrace >> isAssignment [

	^ true
]

{ #category : 'testing' }
ScpAssignmentTrace >> matchesFilter: aString [

	| filter |
	
	filter := aString asLowercase.
	
	^ (super matchesFilter: aString) 
		or: [ 
			(newValue asString asLowercase includesSubstring: filter) or: [ 
				oldValue asString asLowercase includesSubstring: filter 
			] 
		]
		
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
ScpAssignmentTrace >> oldValue [

	^ oldValue
]

{ #category : 'accessing' }
ScpAssignmentTrace >> oldValue: anObject [

	oldValue := anObject
]

{ #category : 'presenters' }
ScpAssignmentTrace >> presenterForDetails [

	^ ScpAssignmentTraceDetailsPresenter on: self
]

{ #category : 'printing' }
ScpAssignmentTrace >> printOn: aStream [

	aStream 
		<< 'Assignment(' 
		<< (self stringFor: [ node variable name ] withDefault: 'unknown node') 
		<< ', ' << (self stringFor: [ oldValue ] withDefault: 'unknown old-value')  
		<< ', ' << (self stringFor: [ newValue ] withDefault: 'unknown new-value')
		<< ')'
]
