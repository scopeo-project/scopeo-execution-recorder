Class {
	#name : 'ScpTraceArrayHandler',
	#superclass : 'ScpInstrumentationHandler',
	#instVars : [
		'rawTraces',
		'lastMessageSender'
	],
	#category : 'Scopeo-TraceRecorder-Trace-Model',
	#package : 'Scopeo-TraceRecorder',
	#tag : 'Trace-Model'
}

{ #category : 'initialization' }
ScpTraceArrayHandler >> initialize [

	rawTraces := OrderedCollection new.
]

{ #category : 'private' }
ScpTraceArrayHandler >> method: aSelector sender: aSender receiver: aReceiver arguments: anArguments [
	
	rawTraces add: #received.
	rawTraces add: aSelector.
	rawTraces add: aSender.
	rawTraces add: aReceiver.
	rawTraces add: anArguments
]

{ #category : 'private' }
ScpTraceArrayHandler >> node: aNodeId assignment: aVariable object: anObject value: aValue [
	
	rawTraces add: #assignment.
	rawTraces add: aNodeId.
	rawTraces add: aVariable.
	rawTraces add: anObject.
	rawTraces add: aValue
]

{ #category : 'private' }
ScpTraceArrayHandler >> node: aNodeId message: aSelector sender: aSender receiver: aReceiver arguments: anArguments [

	rawTraces add: #send.
	rawTraces add: aNodeId.
	rawTraces add: aSelector.
	rawTraces add: aSender.
	rawTraces add: aReceiver.
	rawTraces add: anArguments.
	
	lastMessageSender := aSender.
]

{ #category : 'private' }
ScpTraceArrayHandler >> node: aNodeId messageReturn: aValue [

	rawTraces add: #messageReturn.
	rawTraces add: aNodeId.
	rawTraces add: aValue.
	
	^ aValue
]

{ #category : 'private' }
ScpTraceArrayHandler >> node: aNodeId methodReturn: aValue [

	rawTraces add: #methodReturn.
	rawTraces add: aNodeId.
	rawTraces add: aValue.
	
	^ aValue
]

{ #category : 'private' }
ScpTraceArrayHandler >> node: aNodeId super: aSelector sender: aSender arguments: anArguments [

	rawTraces add: #super.
	rawTraces add: aNodeId.
	rawTraces add: aSelector.
	rawTraces add: aSender.
	rawTraces add: anArguments 
]

{ #category : 'api' }
ScpTraceArrayHandler >> process [
	
	"Create an execution model from the traces"
	| it execution trace |
	
	execution := ScpExecution new.	
	rawTraces ifEmpty: [ ^ execution ].
	it := 1.
	[ it < rawTraces size and: [ (rawTraces at: it) isNotNil ] ] whileTrue: [ 
		
		trace := ScpTrace fromTraces: rawTraces startingAt: it.
		it := it + trace size + 1.
		execution addTrace: trace.
	].
	^ execution 	inspect
	
]

{ #category : 'accessing' }
ScpTraceArrayHandler >> traces [

	| current traces it |

	traces := OrderedCollection new.

	it := 1. 
	[ it < rawTraces size and: [ (rawTraces at: it) isNotNil ] ] whileTrue: [ 
		current := ScpTrace fromTraces: rawTraces startingAt: it.		
		it := it + current size + 1.
		traces add: current.
	].

	^ traces
]
