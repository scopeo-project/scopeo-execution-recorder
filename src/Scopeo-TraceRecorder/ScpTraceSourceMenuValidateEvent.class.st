Class {
	#name : 'ScpTraceSourceMenuValidateEvent',
	#superclass : 'Announcement',
	#instVars : [
		'selection'
	],
	#category : 'Scopeo-TraceRecorder-Source-Menu-UI',
	#package : 'Scopeo-TraceRecorder',
	#tag : 'Source-Menu-UI'
}

{ #category : 'accessing' }
ScpTraceSourceMenuValidateEvent >> selection [

	^ selection
]

{ #category : 'accessing' }
ScpTraceSourceMenuValidateEvent >> selection: anObject [

	selection := anObject
]
