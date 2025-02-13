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

	| code doItReceiver doItContext methodClass method process semaphore |
	self halt.
	code := self selectedTextOrLine.
	(self context respondsTo: #doItReceiver)
		ifTrue: [
			doItReceiver := self context doItReceiver.
			doItContext := self context doItContext ]
		ifFalse: [ doItReceiver := doItContext := nil ].

	methodClass := doItContext
		ifNil: [ doItReceiver class ]
		ifNotNil: [ doItContext methodClass ].

	method := context class compiler
		          source: code;
		          class: methodClass;
		          context: doItContext;
		          requestor: context;
		          isScripting: true;
		          compile.

	semaphore := Semaphore new.
	process := [
		[ 
			method
				valueWithReceiver: doItReceiver
		  		arguments: (method numArgs = 0
				  	ifTrue: [ #(  ) ]
				   ifFalse: [ { doItContext } ]
				)
		] ensure: [ semaphore signalAll ]
	] newProcess.

	process resume.
	semaphore wait
]
