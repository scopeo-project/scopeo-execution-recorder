Class {
	#name : 'ScpSuperMethodCallTrace',
	#superclass : 'ScpMethodCallTrace',
	#category : 'Scopeo-TraceRecorder-old',
	#package : 'Scopeo-TraceRecorder',
	#tag : 'old'
}

{ #category : 'printing' }
ScpSuperMethodCallTrace >> asString [

	^ 'super: ', super asString
]

{ #category : 'testing' }
ScpSuperMethodCallTrace >> isSuperMethodCall [

	^ true
]
