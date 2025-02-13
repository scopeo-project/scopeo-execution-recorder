Class {
	#name : 'ScpExecutionRecorderCmd',
	#superclass : 'SpCodeSelectionCommand',
	#category : 'Scopeo-Execution-Recorder',
	#package : 'Scopeo-Execution-Recorder'
}

{ #category : 'default' }
ScpExecutionRecorderCmd class >> defaultIconName [

	^ #exception
]

{ #category : 'default' }
ScpExecutionRecorderCmd class >> defaultName [ 

	^ 'Record with Scopeo'
]

{ #category : 'default' }
ScpExecutionRecorderCmd class >> defaultShortcutKey [

	^ $x shift meta mac | $x alt control win | $x alt control unix
]

{ #category : 'executing' }
ScpExecutionRecorderCmd >> execute [

	| doItReceiver doItContext |

	(self context respondsTo: #doItReceiver)
		ifTrue: [
			doItReceiver := self context doItReceiver.
			doItContext := self context doItContext ]
		ifFalse: [ doItReceiver := doItContext := nil ].

	(ScpExecutionRecorder new
		forCode: self selectedTextOrLine 
		inContext: doItContext 
		onReceiver: doItReceiver;
		run;
		execution) inspect

]
