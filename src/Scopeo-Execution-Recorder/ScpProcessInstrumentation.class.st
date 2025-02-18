Class {
	#name : 'ScpProcessInstrumentation',
	#superclass : 'ProtoObject',
	#instVars : [
		'process',
		'instrumentation'
	],
	#category : 'Scopeo-Execution-Recorder',
	#package : 'Scopeo-Execution-Recorder'
}

{ #category : 'parameters' }
ScpProcessInstrumentation class >> forProcess: aProcess [

	| proxy process |
	
	proxy := aProcess.
	process := self new.
	
	process become: proxy.
	
	proxy process: process.
	
	^ proxy
]

{ #category : 'reflective operations' }
ScpProcessInstrumentation >> doesNotUnderstand: aMessage [

	^ aMessage sendTo: process
]

{ #category : 'accessing' }
ScpProcessInstrumentation >> instrumentation: anInstrumentation [

	instrumentation := anInstrumentation
]

{ #category : 'accessing' }
ScpProcessInstrumentation >> process: aProcess [

	process := aProcess
]

{ #category : 'stepping - auto' }
ScpProcessInstrumentation >> resume [

	| context |

	instrumentation ifNil: [ ^ process resume ].
	
	context := process suspendedContext.
	
	[ context isDead or: [ process isTerminated ] ] whileFalse: [ 
	
		context method isCompiledMethod ifTrue: [
			context 
				setSender: context sender 
				receiver: context receiver 
				method: (instrumentation applyOn: context method)
				arguments: context arguments
		].
	
		process completeTo: context sender.
		context := process suspendedContext
	]
]
