Class {
	#name : 'ScpSuperMethodCallTrace',
	#superclass : 'ScpMethodCallTrace',
	#category : 'Scopeo-TraceRecorder-Tests',
	#package : 'Scopeo-TraceRecorder',
	#tag : 'Tests'
}

{ #category : 'printing' }
ScpSuperMethodCallTrace >> asString [

	^ 'super: ', super asString
]

{ #category : 'testing' }
ScpSuperMethodCallTrace >> isSuperMethodCall [

	^ true
]
