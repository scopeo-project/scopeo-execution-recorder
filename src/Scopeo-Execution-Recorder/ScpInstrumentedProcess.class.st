Class {
	#name : 'ScpInstrumentedProcess',
	#superclass : 'ProtoObject',
	#instVars : [
		'process',
		'instrumentation',
		'interruptedContext'
	],
	#category : 'Scopeo-Execution-Recorder',
	#package : 'Scopeo-Execution-Recorder'
}

{ #category : 'instance creation' }
ScpInstrumentedProcess class >> from: aProcess [

	^ self new
		process: aProcess;
		yourself
]

{ #category : 'accessing' }
ScpInstrumentedProcess >> context: aContext [

	interruptedContext := aContext 
]

{ #category : 'reflective operations' }
ScpInstrumentedProcess >> doesNotUnderstand: aMessage [

	^ aMessage sendTo: process
]

{ #category : 'accessing' }
ScpInstrumentedProcess >> instrumentation: anInstrumentation [

	instrumentation := anInstrumentation
]

{ #category : 'testing' }
ScpInstrumentedProcess >> isIgnored: aMethod [

	aMethod isInstrumented ifTrue: [ ^ true ].
	aMethod isPrimitive ifTrue: [ ^ true ].
	(aMethod pragmaAt: #noInstrumentation) ifNotNil: [ ^ true ].	

	aMethod methodClass = UndefinedObject ifFalse: [ 
		(aMethod package name beginsWith: #Kernel) ifTrue: [ ^ true ].
		(aMethod package name beginsWith: #UnifiedFFI) ifTrue: [ ^ true ].
		(aMethod package name beginsWith: #Collection) ifTrue: [ ^ true ].
		(aMethod package name beginsWith: #Scopeo) ifTrue: [ ^ true ].
	].

	^ false
]

{ #category : 'accessing' }
ScpInstrumentedProcess >> process: aProcess [

	process := aProcess
]

{ #category : 'stepping - auto' }
ScpInstrumentedProcess >> resume [
	
	| context originalContext pair |


		context := originalContext := process suspendedContext.
		[ context isNil or: [ context isDead or: [ process isTerminated ] ] ] whileFalse: [ 
	
			(context method isCompiledMethod and: [ (self isIgnored: context method) not ]) ifTrue: [
				context 
					setSender: context sender 
					receiver: context receiver 
					method: (instrumentation applyOn: context method)
					arguments: context arguments
			].
	
			pair := context runUntilErrorOrReturnFrom: context.
			context := pair first.
	
			pair second ifNotNil: [ :error |
				thisProcess
				  evaluate: [ LocalProcessException value: error ]
				  onBehalfOf: self.
				process suspendedContext: (error completeProcess: self with: originalContext).
				(OupsDebugRequest newForException: error)
					process: process;
					label: error asString;
					submit.
				context := nil. 
			]
		]
]

{ #category : 'class membership' }
ScpInstrumentedProcess >> yourself [ 

	^ self
]
