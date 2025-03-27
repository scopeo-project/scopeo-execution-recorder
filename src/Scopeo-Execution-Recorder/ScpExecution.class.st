Class {
	#name : 'ScpExecution',
	#superclass : 'Object',
	#instVars : [
		'result',
		'record'
	],
	#category : 'Scopeo-Execution-Recorder-Recording',
	#package : 'Scopeo-Execution-Recorder',
	#tag : 'Recording'
}

{ #category : 'accessing' }
ScpExecution >> record [

	^ record
]

{ #category : 'accessing' }
ScpExecution >> record: anObject [

	record := anObject
]

{ #category : 'accessing' }
ScpExecution >> result [

	^ result
]

{ #category : 'accessing' }
ScpExecution >> result: anObject [

	result := anObject
]
