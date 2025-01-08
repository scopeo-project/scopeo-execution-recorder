Class {
	#name : 'BaselineOfScopeoTraceRecorder',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfScopeoTraceRecorder',
	#package : 'BaselineOfScopeoTraceRecorder'
}

{ #category : 'baselines' }
BaselineOfScopeoTraceRecorder >> baseline: spec [

	<baseline>
		spec for: #common do: [
		self dependencies: spec.
		self packages: spec ]
]

{ #category : 'baselines' }
BaselineOfScopeoTraceRecorder >> dependencies: spec [

	spec baseline: 'ScopeoInstrumentation' with: [
		spec repository: 'github://scopeo-project/scopeo-instrumentation:v2.0.0' 
	].		
	
]

{ #category : 'baselines' }
BaselineOfScopeoTraceRecorder >> packages: spec [

		spec package: 'Scopeo-TraceRecorder-TestObjects'.
		spec
			package: 'Scopeo-TraceRecorder'
			with: [ spec requires: #( 'Scopeo-TraceRecorder-TestObjects' ) ]
]
