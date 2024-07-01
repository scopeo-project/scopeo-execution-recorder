Class {
	#name : 'ScpTraceSourceBrowserValidateEvent',
	#superclass : 'Announcement',
	#instVars : [
		'selection'
	],
	#category : 'Scopeo-TraceRecorder-Source-Browser-UI',
	#package : 'Scopeo-TraceRecorder',
	#tag : 'Source-Browser-UI'
}

{ #category : 'accessing' }
ScpTraceSourceBrowserValidateEvent >> selection [

	^ selection
]

{ #category : 'accessing' }
ScpTraceSourceBrowserValidateEvent >> selection: aScpTraceSourceSelection [

	selection := aScpTraceSourceSelection
]
