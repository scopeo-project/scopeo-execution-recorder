Extension { #name : 'FFICalloutAPI' }

{ #category : '*Scopeo-Execution-Recorder' }
FFICalloutAPI >> senderContext [

	| context |
	context := senderContext.
	context ifNil: [
		context := self findUffiEnterContext sender
	].

	[ context receiver class = ScpExecutionRecorder ] whileTrue: [ 
		context := context sender
	].

	^ context
]
