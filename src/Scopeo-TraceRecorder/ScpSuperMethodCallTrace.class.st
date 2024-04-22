Class {
	#name : 'ScpSuperMethodCallTrace',
	#superclass : 'ScpMethodCallTrace',
	#category : 'Scopeo-TraceRecorder-Model',
	#package : 'Scopeo-TraceRecorder',
	#tag : 'Model'
}

{ #category : 'printing' }
ScpSuperMethodCallTrace >> asString [

	^ 'super: ', super asString
]

{ #category : 'testing' }
ScpSuperMethodCallTrace >> isSuperMethodCall [

	^ true
]
