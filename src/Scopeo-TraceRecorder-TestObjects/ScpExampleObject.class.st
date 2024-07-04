Class {
	#name : 'ScpExampleObject',
	#superclass : 'Object',
	#category : 'Scopeo-TraceRecorder-TestObjects',
	#package : 'Scopeo-TraceRecorder-TestObjects'
}

{ #category : 'as yet unclassified' }
ScpExampleObject >> exampleSuperCall: aValue [

	(ScpInstrumentationRegistry instance at: 12002304)
		method: #exampleSuperCall:
		sender: thisContext sender receiver
		receiver: self
		arguments: { aValue }.

	^ (ScpInstrumentationRegistry instance at: 12002304)
		  node: 1
		  return: aValue
		  sender: thisContext sender receiver
]
