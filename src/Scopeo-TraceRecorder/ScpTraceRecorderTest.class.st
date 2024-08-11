Class {
	#name : 'ScpTraceRecorderTest',
	#superclass : 'TestCase',
	#instVars : [
		'traceRecorder',
		'instVar',
		'observableInstVar'
	],
	#category : 'Scopeo-TraceRecorder-Tests',
	#package : 'Scopeo-TraceRecorder',
	#tag : 'Tests'
}

{ #category : 'initialization' }
ScpTraceRecorderTest >> initialize [

	self class initializeSlots: self.
	super initialize
	
]

{ #category : 'as yet unclassified' }
ScpTraceRecorderTest >> pharoSyntaxExample: aNumber [

	"A method that illustrate every part of Smalltalk syntax"
	<menu>
	
	| y block |
	y := self hash + super hash.
	
	true & false not & (nil isNil) ifTrue: [ 
		block := [ instVar := aNumber].
		observableInstVar := block value.
	].

	instVar = y ifTrue: [ ^ instVar ].

	#($a #a 'a' 1  1.0) do: [ :each |
		Transcript
			show: (each class name);
			show: (each printString);
			show: ' '	
	]	
		
]

{ #category : 'running' }
ScpTraceRecorderTest >> setUp [

	| sourceBuilder |
	sourceBuilder := ScpTraceSourceSelectionBuilder new.
	sourceBuilder matchMethods: (
		OTMatcher identicalTo: (self class >> #pharoSyntaxExample:)
	).

	traceRecorder := ScpTraceRecorder new.
	traceRecorder source: sourceBuilder build.
	traceRecorder handler: ScpTraceListHandler new.

	traceRecorder switchOn.
	traceRecorder startRecording
]

{ #category : 'running' }
ScpTraceRecorderTest >> tearDown [

	super tearDown.
	
	traceRecorder ifNil: [ ^ self ].
	traceRecorder stopRecording.
	traceRecorder switchOff
]

{ #category : 'tests' }
ScpTraceRecorderTest >> testInstVarAssignmentIn2Blocks [

	| trace |

	self pharoSyntaxExample: 42.

	trace := 	self traces at: 18.

	self assert: trace isAssignment.
	self assert: trace node identicalTo: 200.
	self assert: trace object identicalTo: self.
	self assert: trace variable identicalTo: #instVar.
	self assert: trace value identicalTo: 42
]

{ #category : 'tests' }
ScpTraceRecorderTest >> testMessageSent [

	| message return |

	self pharoSyntaxExample: 42.

	message := self traces at: 12.
	return := self traces at: 13.

	self assert: message isMessage.
	self assert: message node identicalTo: 169.
	self assert: message sender identicalTo: self.
	self assert: message selector identicalTo: #isNil.
	self assert: message receiver identicalTo: nil.
	self assert: message arguments isEmpty.
	
	self assert: return isReturn.
	self assert: return isMessageReturn.
	self assert: return node identicalTo: 169.
	self assert: return object identicalTo: true
]

{ #category : 'tests' }
ScpTraceRecorderTest >> testMessageSentInBlock [

	| message return |

	self pharoSyntaxExample: 42.

	message := self traces at: 17.
	return := self traces at: 19.

	self assert: message isMessage.
	self assert: message node identicalTo: 250.
	self assert: message sender identicalTo: self.
	self assert: message selector identicalTo: #value.
	self assert: (message receiver isKindOf: FullBlockClosure).
	self assert: message arguments isEmpty.
	
	self assert: return isReturn.
	self assert: return isMessageReturn .
	self assert: return node identicalTo: 250.
	self assert: return object identicalTo: 42.
]

{ #category : 'tests' }
ScpTraceRecorderTest >> testMessageSentToSelf [

	| message return |

	self pharoSyntaxExample: 42.

	message := self traces at: 2.
	return := self traces at: 3.

	self assert: message isMessage.
	self assert: message node identicalTo: 123.
	self assert: message sender identicalTo: self.
	self assert: message selector identicalTo: #hash.
	self assert: message receiver identicalTo: self.
	self assert: message arguments isEmpty.
	
	self assert: return isReturn.
	self assert: return isMessageReturn.
	self assert: return node identicalTo: 123.
	self assert: return object identicalTo: self hash
]

{ #category : 'tests' }
ScpTraceRecorderTest >> testMessageToSuper [

	| message return |

	self pharoSyntaxExample: 42.

	message := self traces at: 4.
	return := self traces at: 5.

	self assert: message isMessage.
	self assert: message isMessageToSuper.
	self assert: message node identicalTo: 136.
	self assert: message sender identicalTo: self.
	self assert: message selector identicalTo: #hash.
	self assert: message receiver identicalTo: self.
	self assert: message arguments isEmpty.
	
	self assert: return isReturn.
	self assert: return isMessageReturn.
	self assert: return node identicalTo: 136.
	self assert: return object identicalTo: self hash
]

{ #category : 'tests' }
ScpTraceRecorderTest >> testMethodReturn [

	| trace |

	self pharoSyntaxExample: self hash * 2.
	
	trace := 	self traces last.
	
	self assert: trace isReturn.
	self assert: trace isMethodReturn.
	self assert: trace node identicalTo: 285.
	self assert: trace object identicalTo: self hash * 2.	
]

{ #category : 'tests' }
ScpTraceRecorderTest >> testMethodReturnSelfByDefault [

	| trace |

	self pharoSyntaxExample: 42.
	
	trace := 	self traces last.
	
	self assert: trace isReturn.
	self assert: trace isMethodReturn.
	self assert: trace node identicalTo: 0.
	self assert: trace object identicalTo: self.	
]

{ #category : 'tests' }
ScpTraceRecorderTest >> testObservableInstVarAssignmentInBlock [

	| trace |

	self pharoSyntaxExample: 42.

	trace := 	self traces at: 20.

	self assert: trace isAssignment.
	self assert: trace node identicalTo: 223.
	self assert: trace object identicalTo: self.
	self assert: trace variable identicalTo: #observableInstVar.
	self assert: trace value identicalTo: 42
]

{ #category : 'accessing' }
ScpTraceRecorderTest >> traces [ 

	^ traceRecorder handler traces
]
