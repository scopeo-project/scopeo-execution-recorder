Class {
	#name : 'BaselineOfScopeoExecutionRecorder',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfScopeoExecutionRecorder',
	#package : 'BaselineOfScopeoExecutionRecorder'
}

{ #category : 'baselines' }
BaselineOfScopeoExecutionRecorder >> baseline: spec [

	<baseline>
	spec for: #common do: [
		self dependencies: spec.
		self packages: spec 
	]
]

{ #category : 'baselines' }
BaselineOfScopeoExecutionRecorder >> dependencies: spec [

	spec baseline: 'ScopeoInstrumentation' with: [
		spec repository: 'github://scopeo-project/scopeo-instrumentation:main'
	].		
	
]

{ #category : 'baselines' }
BaselineOfScopeoExecutionRecorder >> packages: spec [

	spec package: 'Scopeo-Execution-Recorder'.
	spec package: 'Scopeo-Execution-Recorder-Tests' with: [ 
		spec requires: #( 'Scopeo-Execution-Recorder' ) 
	]
]
