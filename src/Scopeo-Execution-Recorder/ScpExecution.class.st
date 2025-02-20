Class {
	#name : 'ScpExecution',
	#superclass : 'Object',
	#instVars : [
		'traces',
		'stack'
	],
	#category : 'Scopeo-Execution-Recorder',
	#package : 'Scopeo-Execution-Recorder'
}

{ #category : 'initialization' }
ScpExecution >> initialize [

	stack := OrderedCollection new.
	stack add: ScpRoot new
]

{ #category : 'adding' }
ScpExecution >> instruction: anInstruction [

	anInstruction parent: stack last
]

{ #category : 'adding' }
ScpExecution >> method: aMethodTrace [

	aMethodTrace parent: stack last children last.
	stack add: aMethodTrace
]

{ #category : 'removing' }
ScpExecution >> return [

	stack removeLast
]

{ #category : 'accessing' }
ScpExecution >> root [

	^ stack first
]
