Class {
	#name : 'ScpInvocationTrace',
	#superclass : 'ScpTrace',
	#instVars : [
		'arguments'
	],
	#category : 'Scopeo-Execution-Recorder-Traces',
	#package : 'Scopeo-Execution-Recorder',
	#tag : 'Traces'
}

{ #category : 'testing' }
ScpInvocationTrace class >> isAbstract [

	^ self == ScpInvocationTrace
]

{ #category : 'comparing' }
ScpInvocationTrace >> = anInvocation [

	^ super = anInvocation and: [ self receiver = anInvocation receiver and: [ self sender = anInvocation sender and: [ self arguments = anInvocation arguments ] ] ]
]

{ #category : 'accessing' }
ScpInvocationTrace >> arguments [

	^ arguments
]

{ #category : 'accessing' }
ScpInvocationTrace >> arguments: anObject [

	arguments := anObject
]

{ #category : 'testing' }
ScpInvocationTrace >> matchesFilter: aString [

	| filter |
	
	filter := aString asLowercase.
	
	^ (super matchesFilter: aString) 
		or: [ 
			(self receiver asString asLowercase includesSubstring: filter) or: [ 
				(self sender asString asLowercase includesSubstring: filter) or: [ 
					self arguments detect: [ :a | 
						a asString asLowercase includesSubstring: filter 
					] ifFound: [ true ] ifNone: [ false ]	
				]
			] 
		]
		
]

{ #category : 'accessing' }
ScpInvocationTrace >> receiver [

	self subclassResponsibility
]

{ #category : 'accessing' }
ScpInvocationTrace >> sender [

	self subclassResponsibility
]

{ #category : 'printing' }
ScpInvocationTrace >> stringForProperties [

	^ String streamContents: [ :stream | 
		stream	 << (self stringFor: [ node selector ] withDefault: 'unknown node') 
		<< ', ' << (self stringFor: [ self sender ] withDefault: 'unknown sender')
		<< ', ' << (self stringFor: [ self receiver ] withDefault: 'unknown receiver')
		<< ', ' << (self stringFor: [ arguments ] withDefault: 'unknown arguments')		
	]
]
