Class {
	#name : 'ScpExecutionList',
	#superclass : 'ScpExecution',
	#instVars : [
		'traces'
	],
	#category : 'Scopeo-Execution-Recorder',
	#package : 'Scopeo-Execution-Recorder'
}

{ #category : 'converting' }
ScpExecutionList >> asExecutionTree [


	| methods stack index trace popped |
	
	self flag: 'Ugly code to debug the execution tree which does not want to correctly be built for some reasons.'.
	
	methods := OrderedCollection new.
	stack := Stack new.
	index := 1.
		
	[ index > traces size ] whileFalse: [
		trace := traces at: index.	
				
		trace isMethod ifTrue: [ 
			stack push: trace	
		].
	
		(trace isMessage or: [ trace isAssignment ]) ifTrue: [ 
			trace parent: stack top
		].
	
		trace isReturn ifTrue: [ 
			popped := stack pop.
			stack ifEmpty: [ 
				methods add: trace.
			]
		].
	
		index := index + 1	
	].

	^ ScpExecutionTree new 
		methods: methods;
		yourself 
]

{ #category : 'adding' }
ScpExecutionList >> assignment: aScpAssignmentTrace [

	traces add: aScpAssignmentTrace
]

{ #category : 'handling' }
ScpExecutionList >> initialize [

	traces := OrderedCollection new
]

{ #category : 'inspecting' }
ScpExecutionList >> inspection [
	
	<inspectorPresentationOrder: 1 title: 'Execution traces'>
	
	^ ScpExecutionListPresenter on: self
	
]

{ #category : 'adding' }
ScpExecutionList >> message: aScpMessageTrace [

	traces add: aScpMessageTrace
]

{ #category : 'adding' }
ScpExecutionList >> method: aScpMethodTrace [

	traces add: aScpMethodTrace
]

{ #category : 'handling' }
ScpExecutionList >> pop [

	traces add: ScpMethodReturn new
]

{ #category : 'handling' }
ScpExecutionList >> traces [

	^ traces
]
