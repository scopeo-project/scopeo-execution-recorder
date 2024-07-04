Class {
	#name : 'ScpExampleObjectB',
	#superclass : 'ScpExampleObject',
	#instVars : [
		'#exampleInstanceVariable',
		'#exampleInstanceObservable => ObservableSlot'
	],
	#category : 'Scopeo-TraceRecorder-TestObjects',
	#package : 'Scopeo-TraceRecorder-TestObjects'
}

{ #category : 'examples' }
ScpExampleObjectB >> exampleAccessor [

	(ScpInstrumentationRegistry instance at: 12002304)
		method: #exampleAccessor
		sender: thisContext sender receiver
		receiver: self
		arguments: {  }.

	^ (ScpInstrumentationRegistry instance at: 12002304)
		  node: 1
		  return: exampleInstanceVariable
		  sender: thisContext sender receiver
]

{ #category : 'examples' }
ScpExampleObjectB >> exampleSelfCall [

	(ScpInstrumentationRegistry instance at: 12002304)
		method: #exampleSelfCall
		sender: thisContext sender receiver
		receiver: self
		arguments: {  }.

	^ (ScpInstrumentationRegistry instance at: 12002304)
		  node: 1
		  return: ((ScpInstrumentationRegistry instance at: 12002304)
				   node: 2
				   message: #exampleSetter:
				   sender: self
				   receiver: self
				   arguments: { 'exampleSelf' })
		  sender: thisContext sender receiver
]

{ #category : 'examples' }
ScpExampleObjectB >> exampleSetter: aValue [

	(ScpInstrumentationRegistry instance at: 12002304)
		method: #exampleSetter:
		sender: thisContext sender receiver
		receiver: self
		arguments: { aValue }.
	(ScpInstrumentationRegistry instance at: 12002304)
		node: 1
		assignment: [ :v | exampleInstanceVariable := v ]
		variable: #exampleInstanceVariable
		object: self
		value: aValue.
	^ (ScpInstrumentationRegistry instance at: 12002304)
		  node: 2
		  return: self
		  sender: thisContext sender receiver
]

{ #category : 'examples' }
ScpExampleObjectB >> exampleSetterObservableSlot: aValue [

	(ScpInstrumentationRegistry instance at: 12002304)
		method: #exampleSetterObservableSlot:
		sender: thisContext sender receiver
		receiver: self
		arguments: { aValue }.
	(ScpInstrumentationRegistry instance at: 12002304)
		node: 1
		assignment: [ :v | exampleInstanceObservable := v ]
		variable: #exampleInstanceObservable
		object: self
		value: aValue.
	^ (ScpInstrumentationRegistry instance at: 12002304)
		  node: 2
		  return: self
		  sender: thisContext sender receiver
]

{ #category : 'examples' }
ScpExampleObjectB >> exampleSuperCall: aValue [

	^ super exampleSuperCall: aValue
]

{ #category : 'initialization' }
ScpExampleObjectB >> initialize [

	(ScpInstrumentationRegistry instance at: 12002304)
		method: #initialize
		sender: thisContext sender receiver
		receiver: self
		arguments: {  }.
	(ScpInstrumentationRegistry instance at: 12002304)
		node: 1
		message: #initializeSlots:
		sender: self
		receiver: ((ScpInstrumentationRegistry instance at: 12002304)
				 node: 2
				 message: #class
				 sender: self
				 receiver: self
				 arguments: {  })
		arguments: { self }.
	(ScpInstrumentationRegistry instance at: 12002304)
		node: 3
		super: #initialize
		sender: self
		arguments: {  }
		class: ScpExampleObjectB.
	^ (ScpInstrumentationRegistry instance at: 12002304)
		  node: 4
		  return: self
		  sender: thisContext sender receiver
]
