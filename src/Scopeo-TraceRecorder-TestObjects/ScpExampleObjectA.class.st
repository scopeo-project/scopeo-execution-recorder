Class {
	#name : 'ScpExampleObjectA',
	#superclass : 'ScpExampleObject',
	#instVars : [
		'exampleObjectB'
	],
	#category : 'Scopeo-TraceRecorder-TestObjects',
	#package : 'Scopeo-TraceRecorder-TestObjects'
}

{ #category : 'examples' }
ScpExampleObjectA >> exampleAccessorCall [

	(ScpInstrumentationRegistry instance at: 12002304)
		method: #exampleAccessorCall
		sender: thisContext sender receiver
		receiver: self
		arguments: {  }.

	^ (ScpInstrumentationRegistry instance at: 12002304)
		  node: 1
		  return: ((ScpInstrumentationRegistry instance at: 12002304)
				   node: 2
				   message: #exampleAccessor
				   sender: self
				   receiver: exampleObjectB
				   arguments: {  })
		  sender: thisContext sender receiver
]

{ #category : 'as yet unclassified' }
ScpExampleObjectA >> exampleIfTrue [

	| collection |
	(ScpInstrumentationRegistry instance at: 12002304)
		method: #exampleIfTrue
		sender: thisContext sender receiver
		receiver: self
		arguments: {  }.
	collection := OrderedCollection empty.
	(ScpInstrumentationRegistry instance at: 12002304)
		node: 1
		message: #ifTrue:
		sender: self
		receiver: ((ScpInstrumentationRegistry instance at: 12002304)
				 node: 2
				 message: #isEmpty
				 sender: self
				 receiver: collection
				 arguments: {  })
		arguments: { [
			^ (ScpInstrumentationRegistry instance at: 12002304)
				  node: 3
				  return: true
				  sender: thisContext sender receiver ] }.
	^ (ScpInstrumentationRegistry instance at: 12002304)
		  node: 4
		  return: self
		  sender: thisContext sender receiver
]

{ #category : 'examples' }
ScpExampleObjectA >> exampleMethod [

	(ScpInstrumentationRegistry instance at: 12002304)
		method: #exampleMethod
		sender: thisContext sender receiver
		receiver: self
		arguments: {  }.
	(ScpInstrumentationRegistry instance at: 12002304)
		node: 1
		message: #exampleSetter:
		sender: self
		receiver: exampleObjectB
		arguments: { 'example' }.

	[
	(ScpInstrumentationRegistry instance at: 12002304)
		node: 2
		message: #exampleSetter:
		sender: self
		receiver: exampleObjectB
		arguments: { 'exampleInBlock' } ] value.

	^ (ScpInstrumentationRegistry instance at: 12002304)
		  node: 3
		  return: ((ScpInstrumentationRegistry instance at: 12002304)
				   node: 4
				   message: #exampleAccessor
				   sender: self
				   receiver: exampleObjectB
				   arguments: {  })
		  sender: thisContext sender receiver
]

{ #category : 'accessing' }
ScpExampleObjectA >> exampleObjectB: anObject [

	(ScpInstrumentationRegistry instance at: 12002304)
		method: #exampleObjectB:
		sender: thisContext sender receiver
		receiver: self
		arguments: { anObject }.
	(ScpInstrumentationRegistry instance at: 12002304)
		node: 1
		assignment: [ :v | exampleObjectB := v ]
		variable: #exampleObjectB
		object: self
		value: anObject.
	^ (ScpInstrumentationRegistry instance at: 12002304)
		  node: 2
		  return: self
		  sender: thisContext sender receiver
]

{ #category : 'examples' }
ScpExampleObjectA >> exampleSetterCall [

	(ScpInstrumentationRegistry instance at: 12002304)
		method: #exampleSetterCall
		sender: thisContext sender receiver
		receiver: self
		arguments: {  }.
	(ScpInstrumentationRegistry instance at: 12002304)
		node: 1
		message: #exampleSetter:
		sender: self
		receiver: exampleObjectB
		arguments: { 'example' }.
	^ (ScpInstrumentationRegistry instance at: 12002304)
		  node: 2
		  return: self
		  sender: thisContext sender receiver
]

{ #category : 'examples' }
ScpExampleObjectA >> exampleSetterCallInBlock [

	(ScpInstrumentationRegistry instance at: 12002304)
		method: #exampleSetterCallInBlock
		sender: thisContext sender receiver
		receiver: self
		arguments: {  }.

	[
	(ScpInstrumentationRegistry instance at: 12002304)
		node: 1
		message: #exampleSetter:
		sender: self
		receiver: exampleObjectB
		arguments: { 'exampleInBlock' } ] value.
	^ (ScpInstrumentationRegistry instance at: 12002304)
		  node: 2
		  return: self
		  sender: thisContext sender receiver
]

{ #category : 'examples' }
ScpExampleObjectA >> exampleSetterCallInBlockInBlock [

	| value |
	(ScpInstrumentationRegistry instance at: 12002304)
		method: #exampleSetterCallInBlockInBlock
		sender: thisContext sender receiver
		receiver: self
		arguments: {  }.
	value := 'exampleInBlockInBlock'.
	[ :v |
	[
	(ScpInstrumentationRegistry instance at: 12002304)
		node: 1
		message: #exampleSetter:
		sender: self
		receiver: exampleObjectB
		arguments: { v } ] value ] value: value.
	^ (ScpInstrumentationRegistry instance at: 12002304)
		  node: 2
		  return: self
		  sender: thisContext sender receiver
]

{ #category : 'examples' }
ScpExampleObjectA >> exampleSetterObservableCall [

	(ScpInstrumentationRegistry instance at: 12002304)
		method: #exampleSetterObservableCall
		sender: thisContext sender receiver
		receiver: self
		arguments: {  }.
	(ScpInstrumentationRegistry instance at: 12002304)
		node: 1
		message: #exampleSetterObservableSlot:
		sender: self
		receiver: exampleObjectB
		arguments: { 'exampleObservable' }.
	^ (ScpInstrumentationRegistry instance at: 12002304)
		  node: 2
		  return: self
		  sender: thisContext sender receiver
]

{ #category : 'as yet unclassified' }
ScpExampleObjectA >> exampleWithCascade [

	(ScpInstrumentationRegistry instance at: 12002304)
		method: #exampleWithCascade
		sender: thisContext sender receiver
		receiver: self
		arguments: {  }.

	^ (ScpInstrumentationRegistry instance at: 12002304)
		  node: 1
		  return: [
			  | receiver |
			  receiver := self.
			  (ScpInstrumentationRegistry instance at: 12002304)
				  node: 2
				  message: #exampleIfTrue
				  sender: self
				  receiver: receiver
				  arguments: {  }.
			  (ScpInstrumentationRegistry instance at: 12002304)
				  node: 3
				  message: #exampleMethod
				  sender: self
				  receiver: receiver
				  arguments: {  }.
			  (ScpInstrumentationRegistry instance at: 12002304)
				  node: 4
				  message: #exampleObjectB:
				  sender: self
				  receiver: receiver
				  arguments: { 'test' }.
			  (ScpInstrumentationRegistry instance at: 12002304)
				  node: 5
				  message: #yourself
				  sender: self
				  receiver: receiver
				  arguments: {  } ] value
		  sender: thisContext sender receiver
]
