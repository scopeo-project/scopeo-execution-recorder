Class {
	#name : 'ScpMethodUntraced',
	#superclass : 'ScpMethod',
	#category : 'Scopeo-Execution-Recorder',
	#package : 'Scopeo-Execution-Recorder'
}

{ #category : 'accessing' }
ScpMethodUntraced >> children [

	self error: 'The method ', method name, ' was ignored from the tracing system.'
]
