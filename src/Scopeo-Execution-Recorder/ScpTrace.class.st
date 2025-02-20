Class {
	#name : 'ScpTrace',
	#superclass : 'Object',
	#instVars : [
		'parent',
		'children'
	],
	#category : 'Scopeo-Execution-Recorder',
	#package : 'Scopeo-Execution-Recorder'
}

{ #category : 'testing' }
ScpTrace class >> isAbstract [

	^ self == ScpTrace
]

{ #category : 'adding' }
ScpTrace >> addChild: anObject [

	children add: anObject
]

{ #category : 'accessing' }
ScpTrace >> children [

	^ children
]

{ #category : 'accessing' }
ScpTrace >> children: anObject [

	children := anObject
]

{ #category : 'initialization' }
ScpTrace >> initialize [

	children := OrderedCollection new
]

{ #category : 'testing' }
ScpTrace >> isAssignment [

	^ false
]

{ #category : 'testing' }
ScpTrace >> isInstruction [

	^ false
]

{ #category : 'testing' }
ScpTrace >> isMessage [

	^ false
]

{ #category : 'testing' }
ScpTrace >> isMethod [

	^ false
]

{ #category : 'testing' }
ScpTrace >> isRoot [

	^ false
]

{ #category : 'accessing' }
ScpTrace >> parent [

	^ parent
]

{ #category : 'accessing' }
ScpTrace >> parent: anObject [

	parent := anObject.
	parent addChild: self 
]

{ #category : 'as yet unclassified' }
ScpTrace >> siblings [

	^ self parent children copy remove: self
]
