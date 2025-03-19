Class {
	#name : 'ScpInvocationTrace',
	#superclass : 'ScpTrace',
	#instVars : [
		'arguments'
	],
	#category : 'Scopeo-Execution-Recorder',
	#package : 'Scopeo-Execution-Recorder'
}

{ #category : 'testing' }
ScpInvocationTrace class >> isAbstract [

	^ self == ScpInvocationTrace
]

{ #category : 'accessing' }
ScpInvocationTrace >> arguments [

	^ arguments
]

{ #category : 'accessing' }
ScpInvocationTrace >> arguments: anObject [

	arguments := anObject
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
