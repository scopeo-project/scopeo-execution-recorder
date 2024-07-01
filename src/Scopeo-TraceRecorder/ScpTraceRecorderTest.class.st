Class {
	#name : 'ScpTraceRecorderTest',
	#superclass : 'TestCase',
	#instVars : [
		'traceRecorder',
		'objectA',
		'objectB'
	],
	#category : 'Scopeo-TraceRecorder-Tests',
	#package : 'Scopeo-TraceRecorder',
	#tag : 'Tests'
}

{ #category : 'running' }
ScpTraceRecorderTest >> setUp [

	| sourceBuilder |
	
	objectB := ScpExampleObjectB new.
	objectA := ScpExampleObjectA new
		           exampleObjectB: objectB;
		           yourself.

	sourceBuilder := ScpTraceSourceSelectionBuilder new.
	sourceBuilder matchPackages:
		(OTMatcher name: ScpExampleObjectA package name).

	traceRecorder := ScpTraceRecorder new.
	traceRecorder source: sourceBuilder build.
	traceRecorder handler: ScpTraceListStorage new.

	traceRecorder switchOn.
	traceRecorder startRecording
]

{ #category : 'running' }
ScpTraceRecorderTest >> tearDown [

	super tearDown.
	traceRecorder stopRecording.
	traceRecorder switchOff
]

{ #category : 'tests' }
ScpTraceRecorderTest >> testExampleAccessorCall [

	| traces |
	objectA exampleAccessorCall.

	traces := traceRecorder handler traces.

	self assert: traces size equals: 4.
	self assert: traces first isMethodCall equals: true.
	self assert: traces first sender identicalTo: self.
	self assert: traces first selector equals: #exampleAccessorCall.
	self assert: traces first receiver identicalTo: objectA.
	self assert: traces first arguments isEmpty equals: true.

	self assert: traces second isMethodCall equals: true.
	self assert: traces second sender identicalTo: objectA.
	self assert: traces second selector equals: #exampleAccessor.
	self assert: traces second receiver identicalTo: objectB.
	self assert: traces second arguments isEmpty equals: true.

	self assert: traces third isMethodReturn equals: true.
	self assert: traces third value equals: nil.
	
	self assert: traces fourth isMethodReturn equals: true.
	self assert: traces fourth value equals: nil.


]

{ #category : 'tests' }
ScpTraceRecorderTest >> testExampleIfTrue [

	self assert: objectA exampleIfTrue equals: true
]

{ #category : 'tests' }
ScpTraceRecorderTest >> testExampleMethod [

	objectA exampleMethod
]

{ #category : 'tests' }
ScpTraceRecorderTest >> testExampleSelfCall [

	| traces |
	objectB exampleSelfCall.

	traces := traceRecorder handler traces.

	self assert: traces size equals: 5.
	self assert: traces first isMethodCall equals: true.
	self assert: traces first sender identicalTo: self.
	self assert: traces first selector equals: #exampleSelfCall.
	self assert: traces first receiver identicalTo: objectB.
	self assert: traces first arguments isEmpty equals: true.

	self assert: traces second isMethodCall equals: true.
	self assert: traces second sender identicalTo: objectB.
	self assert: traces second selector equals: #exampleSetter:.
	self assert: traces second receiver identicalTo: objectB.
	self assert: traces second arguments size equals: 1.
	self assert: traces second arguments first equals: 'exampleSelf'.

	self assert: traces third isAssignment equals: true.
	self assert: traces third object identicalTo: objectB.
	self assert: traces third variable equals: #exampleInstanceVariable.
	self assert: traces third value equals: 'exampleSelf'.
	
	self assert: traces fourth isMethodReturn equals: true.
	self assert: traces fourth value identicalTo: objectB.

	self assert: traces fifth isMethodReturn equals: true.
	self assert: traces fifth value identicalTo: objectB.
]

{ #category : 'tests' }
ScpTraceRecorderTest >> testExampleSetterCall [

	| traces |
	objectA exampleSetterCall.

	traces := traceRecorder handler traces.

	self assert: traces size equals: 5.
	self assert: traces first isMethodCall equals: true.
	self assert: traces first sender identicalTo: self.
	self assert: traces first selector equals: #exampleSetterCall.
	self assert: traces first receiver identicalTo: objectA.
	self assert: traces first arguments isEmpty equals: true.

	self assert: traces second isMethodCall equals: true.
	self assert: traces second sender identicalTo: objectA.
	self assert: traces second selector equals: #exampleSetter:.
	self assert: traces second receiver identicalTo: objectB.
	self assert: traces second arguments size equals: 1.
	self assert: traces second arguments first equals: 'example'.

	self assert: traces third isAssignment equals: true.
	self assert: traces third object identicalTo: objectB.
	self assert: traces third variable equals: #exampleInstanceVariable.
	self assert: traces third value equals: 'example'.

	self assert: traces fourth isMethodReturn equals: true.
	self assert: traces fourth value identicalTo: objectB.

	self assert: traces fifth isMethodReturn equals: true.
	self assert: traces fifth value identicalTo: objectA
]

{ #category : 'tests' }
ScpTraceRecorderTest >> testExampleSetterCallInBlock [

	| traces |
	objectA exampleSetterCallInBlock.

	traces := traceRecorder handler traces.

	self assert: traces size equals: 5.
	self assert: traces first isMethodCall equals: true.
	self assert: traces first sender identicalTo: self.
	self assert: traces first selector equals: #exampleSetterCallInBlock.
	self assert: traces first receiver identicalTo: objectA.
	self assert: traces first arguments isEmpty equals: true.

	self assert: traces second isMethodCall equals: true.
	self assert: traces second sender identicalTo: objectA.
	self assert: traces second selector equals: #exampleSetter:.
	self assert: traces second receiver identicalTo: objectB.
	self assert: traces second arguments size equals: 1.
	self assert: traces second arguments first equals: 'exampleInBlock'.

	self assert: traces third isAssignment equals: true.
	self assert: traces third object identicalTo: objectB.
	self assert: traces third variable equals: #exampleInstanceVariable.
	self assert: traces third value equals: 'exampleInBlock'.

	self assert: traces fourth isMethodReturn equals: true.
	self assert: traces fourth value identicalTo: objectB.

	self assert: traces fifth isMethodReturn equals: true.
	self assert: traces fifth value identicalTo: objectA
]

{ #category : 'tests' }
ScpTraceRecorderTest >> testExampleSetterCallInBlockInBlock [

	| traces |
	objectA exampleSetterCallInBlockInBlock.

	traces := traceRecorder handler traces.

	self assert: traces size equals: 5.
	self assert: traces first isMethodCall equals: true.
	self assert: traces first sender identicalTo: self.
	self
		assert: traces first selector
		equals: #exampleSetterCallInBlockInBlock.
	self assert: traces first receiver identicalTo: objectA.
	self assert: traces first arguments isEmpty equals: true.

	self assert: traces second isMethodCall equals: true.
	self assert: traces second sender identicalTo: objectA.
	self assert: traces second selector equals: #exampleSetter:.
	self assert: traces second receiver identicalTo: objectB.
	self assert: traces second arguments size equals: 1.
	self
		assert: traces second arguments first
		equals: 'exampleInBlockInBlock'.

	self assert: traces third isAssignment equals: true.
	self assert: traces third object identicalTo: objectB.
	self assert: traces third variable equals: #exampleInstanceVariable.
	self assert: traces third value equals: 'exampleInBlockInBlock'.

	self assert: traces fourth isMethodReturn equals: true.
	self assert: traces fourth value identicalTo: objectB.

	self assert: traces fifth isMethodReturn equals: true.
	self assert: traces fifth value identicalTo: objectA
]

{ #category : 'tests' }
ScpTraceRecorderTest >> testExampleSetterObservableCall [

	| traces |
	objectA exampleSetterObservableCall.

	traces := traceRecorder handler traces.

	self assert: traces size equals: 5.
	self assert: traces first isMethodCall equals: true.
	self assert: traces first sender identicalTo: self.
	self
		assert: traces first selector
		equals: #exampleSetterObservableCall.
	self assert: traces first receiver identicalTo: objectA.
	self assert: traces first arguments isEmpty equals: true.

	self assert: traces second isMethodCall equals: true.
	self assert: traces second sender identicalTo: objectA.
	self
		assert: traces second selector
		equals: #exampleSetterObservableSlot:.
	self assert: traces second receiver identicalTo: objectB.
	self assert: traces second arguments size equals: 1.
	self assert: traces second arguments first equals: 'exampleObservable'.

	self assert: traces third isAssignment equals: true.
	self assert: traces third object identicalTo: objectB.
	self assert: traces third variable equals: #exampleInstanceObservable.
	self assert: traces third value equals: 'exampleObservable'.

	self assert: traces fourth isMethodReturn equals: true.
	self assert: traces fourth value identicalTo: objectB.

	self assert: traces fifth isMethodReturn equals: true.
	self assert: traces fifth value identicalTo: objectA
]

{ #category : 'tests' }
ScpTraceRecorderTest >> testExampleSuperCall [

	| traces |
	objectB exampleSuperCall: 'exampleSuper'.

	traces := traceRecorder handler traces.

	self assert: traces size equals: 4.
	self assert: traces first isMethodCall equals: true.
	self assert: traces first sender identicalTo: self.
	self assert: traces first selector equals: #exampleSuperCall:.
	self assert: traces first receiver identicalTo: objectB.
	self assert: traces second arguments size equals: 1.
	self assert: traces second arguments first equals: 'exampleSuper'.

	self assert: traces second isMethodCall equals: true.
	self assert: traces second isSuperMethodCall equals: true.
	self assert: traces second selector equals: #exampleSuperCall:.
	self assert: traces second sender identicalTo: objectB.
	self assert: traces second receiver identicalTo: objectB.
	self assert: traces second arguments size equals: 1.
	self assert: traces second arguments first equals: 'exampleSuper'.
	
	
	self assert: traces third isMethodReturn equals: true.
	self assert: traces third value equals: 'exampleSuper'.
	
	self assert: traces fourth isMethodReturn equals: true.
	self assert: traces fourth value equals: 'exampleSuper'.

]
