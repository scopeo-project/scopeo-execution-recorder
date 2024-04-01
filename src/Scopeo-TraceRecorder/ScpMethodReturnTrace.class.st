Class {
	#name : #ScpMethodReturnTrace,
	#superclass : #ScpTrace,
	#instVars : [
		'value'
	],
	#category : #'Scopeo-TraceRecorder-Model'
}

{ #category : #converting }
ScpMethodReturnTrace >> asString [

	^ 'return ', value asString
]

{ #category : #testing }
ScpMethodReturnTrace >> isMethodReturn [

	^ true
]

{ #category : #accessing }
ScpMethodReturnTrace >> value [

	^ value
]

{ #category : #accessing }
ScpMethodReturnTrace >> value: anObject [

	value := anObject
]
