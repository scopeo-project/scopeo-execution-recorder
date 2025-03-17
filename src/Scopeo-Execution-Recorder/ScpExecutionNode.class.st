Class {
	#name : 'ScpExecutionNode',
	#superclass : 'Object',
	#instVars : [
		'parent',
		'children',
		'isRecorded',
		'operation'
	],
	#category : 'Scopeo-Execution-Recorder',
	#package : 'Scopeo-Execution-Recorder'
}

{ #category : 'initialization' }
ScpExecutionNode >> addChild: aScpExecutionNode [

	children add: aScpExecutionNode
]

{ #category : 'accessing' }
ScpExecutionNode >> children [

	^ children
]

{ #category : 'initialization' }
ScpExecutionNode >> initialize [

	isRecorded := true.
	children := OrderedCollection new
]

{ #category : 'accessing' }
ScpExecutionNode >> isRecorded [

	^ isRecorded
]

{ #category : 'accessing' }
ScpExecutionNode >> operation [

	^ operation
]

{ #category : 'accessing' }
ScpExecutionNode >> operation: aScpOperation [

	operation := aScpOperation
]

{ #category : 'initialization' }
ScpExecutionNode >> parent: aScpExecutionNode [

	parent := aScpExecutionNode.
	parent addChild: self
]

{ #category : 'printing' }
ScpExecutionNode >> printOn: aStream [

	aStream << operation asString
]

{ #category : 'accessing' }
ScpExecutionNode >> recorded: aBoolean [

	isRecorded := aBoolean
]
