Class {
	#name : #ScpExampleObjectA,
	#superclass : #ScpExampleObject,
	#instVars : [
		'exampleObjectB'
	],
	#category : #'Scopeo-TraceRecorder-TestObjects'
}

{ #category : #examples }
ScpExampleObjectA >> exampleAccessorCall [

	(ScpInstrumentationRegistry instance at: 837734912)
		method: #exampleAccessorCall
		from: thisContext sender receiver
		to: self
		with: {  }.

	^ (ScpInstrumentationRegistry instance at: 837734912) methodReturn:
		  ((ScpInstrumentationRegistry instance at: 837734912)
			   message: #exampleAccessor
			   from: self
			   to: exampleObjectB
			   with: {  })
]

{ #category : #'as yet unclassified' }
ScpExampleObjectA >> exampleIfTrue [

	| collection |
	(ScpInstrumentationRegistry instance at: 837734912)
		method: #exampleIfTrue
		from: thisContext sender receiver
		to: self
		with: {  }.
	collection := (ScpInstrumentationRegistry instance at: 837734912)
		              message: #empty
		              from: self
		              to: OrderedCollection
		              with: {  }.
	(ScpInstrumentationRegistry instance at: 837734912)
		message: #ifTrue:
		from: self
		to: ((ScpInstrumentationRegistry instance at: 837734912)
				 message: #isEmpty
				 from: self
				 to: collection
				 with: {  })
		with: { [
			^ (ScpInstrumentationRegistry instance at: 837734912)
				  methodReturn: true ] }.
	^ (ScpInstrumentationRegistry instance at: 837734912) methodReturn:
		  self
]

{ #category : #examples }
ScpExampleObjectA >> exampleMethod [

	(ScpInstrumentationRegistry instance at: 837734912)
		method: #exampleMethod
		from: thisContext sender receiver
		to: self
		with: {  }.
	(ScpInstrumentationRegistry instance at: 837734912)
		message: #exampleSetter:
		from: self
		to: exampleObjectB
		with: { 'example' }.

	[
	(ScpInstrumentationRegistry instance at: 837734912)
		message: #exampleSetter:
		from: self
		to: exampleObjectB
		with: { 'exampleInBlock' } ] value.

	^ (ScpInstrumentationRegistry instance at: 837734912) methodReturn:
		  ((ScpInstrumentationRegistry instance at: 837734912)
			   message: #exampleAccessor
			   from: self
			   to: exampleObjectB
			   with: {  })
]

{ #category : #accessing }
ScpExampleObjectA >> exampleObjectB: anObject [

	(ScpInstrumentationRegistry instance at: 837734912)
		method: #exampleObjectB:
		from: thisContext sender receiver
		to: self
		with: { anObject }.
	(ScpInstrumentationRegistry instance at: 837734912)
		assignment: [ exampleObjectB := anObject ]
		variable: #exampleObjectB
		of: self
		value: anObject.
	^ (ScpInstrumentationRegistry instance at: 837734912) methodReturn:
		  self
]

{ #category : #examples }
ScpExampleObjectA >> exampleSetterCall [

	(ScpInstrumentationRegistry instance at: 837734912)
		method: #exampleSetterCall
		from: thisContext sender receiver
		to: self
		with: {  }.
	(ScpInstrumentationRegistry instance at: 837734912)
		message: #exampleSetter:
		from: self
		to: exampleObjectB
		with: { 'example' }.
	^ (ScpInstrumentationRegistry instance at: 837734912) methodReturn:
		  self
]

{ #category : #examples }
ScpExampleObjectA >> exampleSetterCallInBlock [

	(ScpInstrumentationRegistry instance at: 837734912)
		method: #exampleSetterCallInBlock
		from: thisContext sender receiver
		to: self
		with: {  }.

	[
	(ScpInstrumentationRegistry instance at: 837734912)
		message: #exampleSetter:
		from: self
		to: exampleObjectB
		with: { 'exampleInBlock' } ] value.
	^ (ScpInstrumentationRegistry instance at: 837734912) methodReturn:
		  self
]

{ #category : #examples }
ScpExampleObjectA >> exampleSetterCallInBlockInBlock [

	| value |
	(ScpInstrumentationRegistry instance at: 837734912)
		method: #exampleSetterCallInBlockInBlock
		from: thisContext sender receiver
		to: self
		with: {  }.
	value := 'exampleInBlockInBlock'.
	[ :v |
	[
	(ScpInstrumentationRegistry instance at: 837734912)
		message: #exampleSetter:
		from: self
		to: exampleObjectB
		with: { v } ] value ] value: value.
	^ (ScpInstrumentationRegistry instance at: 837734912) methodReturn:
		  self
]

{ #category : #examples }
ScpExampleObjectA >> exampleSetterObservableCall [

	(ScpInstrumentationRegistry instance at: 837734912)
		method: #exampleSetterObservableCall
		from: thisContext sender receiver
		to: self
		with: {  }.
	(ScpInstrumentationRegistry instance at: 837734912)
		message: #exampleSetterObservableSlot:
		from: self
		to: exampleObjectB
		with: { 'exampleObservable' }.
	^ (ScpInstrumentationRegistry instance at: 837734912) methodReturn:
		  self
]
