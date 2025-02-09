Class {
	#name : 'ScpContextMethodHandler',
	#superclass : 'Object',
	#instVars : [
		'block',
		'before',
		'after'
	],
	#category : 'Scopeo-Execution-Recorder',
	#package : 'Scopeo-Execution-Recorder'
}

{ #category : 'services' }
ScpContextMethodHandler >> afterExecutionDo: aBlock [

	after := aBlock
]

{ #category : 'parameters' }
ScpContextMethodHandler >> attachToContext: aContext [
	
	aContext 
		setSender: aContext sender 
		receiver: self 
		method: self class >> #executeContext: 
		arguments: { aContext copy } 
]

{ #category : 'services' }
ScpContextMethodHandler >> beforeExecutionDo: aBlock [

	before := aBlock
]

{ #category : 'private' }
ScpContextMethodHandler >> executeContext: aContext [

	| result |

	before value.
	
	result := aContext receiver 
		withArgs: aContext arguments 
		executeMethod: aContext method.

	after value.
	
	^ result 
]
