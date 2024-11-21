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


	spec baseline: 'ScopeoCommon' with: [
		spec repository:
			'github://scopeo-project/scopeo-common:main' ].

	spec baseline: 'ScopeoInstrumentation' with: [
		spec repository:
			'github://scopeo-project/scopeo-instrumentation:v1.0' ].		
	spec baseline: 'ScopeoStore' with: [
		spec repository:
			'github://scopeo-project/scopeo-store:main' ].

	spec package: 'OpenTelemetry-Matchers' with: [
		spec repository: 'github://Gabriel-Darbord/opentelemetry-pharo:main' ]
]

{ #category : 'baselines' }
BaselineOfScopeoTraceRecorder >> packages: spec [

		spec package: 'Scopeo-TraceRecorder-TestObjects'.
		spec
			package: 'Scopeo-TraceRecorder'
			with: [ spec requires: #( 'Scopeo-TraceRecorder-TestObjects' ) ]
]
