Class {
	#name : 'ScpBicycle',
	#superclass : 'ScpVehicle',
	#traits : 'TObservable',
	#classTraits : 'TObservable classTrait',
	#instVars : [
		'#gear',
		'#rpm',
		'#status => ObservableSlot',
		'#process'
	],
	#category : 'Scopeo-Execution-Recorder-Tests',
	#package : 'Scopeo-Execution-Recorder-Tests'
}

{ #category : 'action' }
ScpBicycle >> break [

	status := #break
]

{ #category : 'as yet unclassified' }
ScpBicycle >> drive [

	^ super drive
]

{ #category : 'parameters' }
ScpBicycle >> gear: anInteger [

	gear := anInteger
]

{ #category : 'initialization' }
ScpBicycle >> initialize [

	self class initializeSlots: self.
	super initialize.

	status := #cycling.
	self property: #status whenChangedDo: [ :s | 

		s = #break ifTrue: [ 
			self rpm: (rpm - 10 max: 0).
			status := #cycling.
		]
	]
	
	
]

{ #category : 'accessing' }
ScpBicycle >> rpm [

	^rpm
]

{ #category : 'parameters' }
ScpBicycle >> rpm: anInteger [

	rpm := anInteger
]

{ #category : 'accessing' }
ScpBicycle >> speed [

	^ gear * rpm
]
