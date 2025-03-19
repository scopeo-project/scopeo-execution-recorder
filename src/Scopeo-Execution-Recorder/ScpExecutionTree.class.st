Class {
	#name : 'ScpExecutionTree',
	#superclass : 'ScpExecution',
	#instVars : [
		'stack',
		'methods'
	],
	#category : 'Scopeo-Execution-Recorder',
	#package : 'Scopeo-Execution-Recorder'
}

{ #category : 'initialization' }
ScpExecutionTree >> initialize [

	stack := OrderedCollection new.
	methods := OrderedCollection new
]

{ #category : 'inspecting' }
ScpExecutionTree >> inspection [
	
	<inspectorPresentationOrder: 1 title: 'Execution tree'>
	
	^ SpTreePresenter new
		roots: self methods ;
		children: [ :node | node children ];
		display: [ :node | node asString ];
		expandRoots;
		yourself
]

{ #category : 'adding' }
ScpExecutionTree >> instruction: anInstruction [

	anInstruction parent: stack last
]

{ #category : 'adding' }
ScpExecutionTree >> method: aMethodTrace [

	stack isEmpty ifFalse: [ 
		aMethodTrace parent: stack last children last 
	].

	aMethodTrace isTracked ifTrue: [ 	
		stack add: aMethodTrace
	]
	
]

{ #category : 'accessing' }
ScpExecutionTree >> methods [

	^ methods
]

{ #category : 'removing' }
ScpExecutionTree >> return [

	| method |
	method := stack removeLast.
	stack ifEmpty: [ 
		methods add: method 
	]
]
