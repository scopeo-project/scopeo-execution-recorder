Class {
	#name : #ScpExampleObjectB,
	#superclass : #ScpExampleObject,
	#instVars : [
		'#exampleInstanceVariable',
		'#exampleInstanceObservable => ObservableSlot'
	],
	#category : #'Scopeo-TraceRecorder-TestObjects'
}

{ #category : #examples }
ScpExampleObjectB >> exampleAccessor [

	(ScpInstrumentationRegistry instance at: 837734912)
		method: #exampleAccessor
		from: thisContext sender receiver
		to: self
		with: {  }.

	^ (ScpInstrumentationRegistry instance at: 837734912) methodReturn:
		  exampleInstanceVariable
]

{ #category : #examples }
ScpExampleObjectB >> exampleSelfCall [

	(ScpInstrumentationRegistry instance at: 837734912)
		method: #exampleSelfCall
		from: thisContext sender receiver
		to: self
		with: {  }.

	^ (ScpInstrumentationRegistry instance at: 837734912) methodReturn:
		  ((ScpInstrumentationRegistry instance at: 837734912)
			   message: #exampleSetter:
			   from: self
			   to: self
			   with: { 'exampleSelf' })
]

{ #category : #examples }
ScpExampleObjectB >> exampleSetter: aValue [

	(ScpInstrumentationRegistry instance at: 837734912)
		method: #exampleSetter:
		from: thisContext sender receiver
		to: self
		with: { aValue }.
	(ScpInstrumentationRegistry instance at: 837734912)
		assignment: [ exampleInstanceVariable := aValue ]
		variable: #exampleInstanceVariable
		of: self
		value: aValue.
	^ (ScpInstrumentationRegistry instance at: 837734912) methodReturn:
		  self
]

{ #category : #examples }
ScpExampleObjectB >> exampleSetterObservableSlot: aValue [

	(ScpInstrumentationRegistry instance at: 837734912)
		method: #exampleSetterObservableSlot:
		from: thisContext sender receiver
		to: self
		with: { aValue }.
	(ScpInstrumentationRegistry instance at: 837734912)
		assignment: [ exampleInstanceObservable := aValue ]
		variable: #exampleInstanceObservable
		of: self
		value: aValue.
	^ (ScpInstrumentationRegistry instance at: 837734912) methodReturn:
		  self
]

{ #category : #examples }
ScpExampleObjectB >> exampleSuperCall: aValue [

	(ScpInstrumentationRegistry instance at: 837734912)
		method: #exampleSuperCall:
		from: thisContext sender receiver
		to: self
		with: { aValue }.

	^ (ScpInstrumentationRegistry instance at: 837734912) methodReturn:
		  (super exampleSuperCall: aValue)
]

{ #category : #initialization }
ScpExampleObjectB >> initialize [

	(ScpInstrumentationRegistry instance at: 837734912)
		method: #initialize
		from: thisContext sender receiver
		to: self
		with: {  }.
	(ScpInstrumentationRegistry instance at: 837734912)
		message: #initializeSlots:
		from: self
		to: ((ScpInstrumentationRegistry instance at: 837734912)
				 message: #class
				 from: self
				 to: self
				 with: {  })
		with: { self }.
	super initialize.
	^ (ScpInstrumentationRegistry instance at: 837734912) methodReturn:
		  self
]
