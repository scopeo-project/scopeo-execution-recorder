Class {
	#name : 'ScpExecutionRecorderTest',
	#superclass : 'TestCase',
	#instVars : [
		'semaphore'
	],
	#category : 'Scopeo-Execution-Recorder-Tests',
	#package : 'Scopeo-Execution-Recorder-Tests'
}

{ #category : 'tests' }
ScpExecutionRecorderTest class >> testMethodWithArgument [
]

{ #category : 'as yet unclassified' }
ScpExecutionRecorderTest >> executeProcess: aProcess [

	aProcess resume.
	semaphore wait
]

{ #category : 'as yet unclassified' }
ScpExecutionRecorderTest >> newProcessFor: aBlock [
	
	^ Process 
		forContext: [ 
			aBlock value.
			semaphore signal.
			Processor terminateRealActive.
		] asContext 
		priority: thisProcess priority.
]

{ #category : 'as yet unclassified' }
ScpExecutionRecorderTest >> setUp [

	super setUp.
	
	semaphore := Semaphore new
]

{ #category : 'tests' }
ScpExecutionRecorderTest >> testMethodWithArgument [

	| bicycle execution recorder process |

	"Arrange"
	bicycle := ScpBicycle new.
	execution := ScpExecutionList new.
	
	recorder := ScpExecutionRecorder new
		execution: execution;
		yourself.	

	process := self newProcessFor: [ 
		bicycle gear: 2.	
		bicycle rpm: 10.
	].

	"Act"
	recorder process: process.
	self executeProcess: process.	

	"Assert"
	
	self assert: execution traces size equals: 4.

	self assert: execution traces first isMethod.	
	self assert: execution traces first node selector equals: #gear:.

	self assert: execution traces second isAssignment.
	self assert: execution traces second node variable name equals: #gear.
	
	self assert: execution traces third isMethod.	
	self assert: execution traces third node selector equals: #rpm:.
	
	self assert: execution traces fourth isAssignment.
	self assert: execution traces fourth node variable name equals: #rpm.
	
]

{ #category : 'tests' }
ScpExecutionRecorderTest >> testMethodWithObservableVariable [

	| bicycle execution recorder process |

	"Arrange"
	bicycle := ScpBicycle new.
	bicycle gear: 2.	
	bicycle rpm: 10.
	
	execution := ScpExecutionList new.
	recorder := ScpExecutionRecorder new
		execution: execution;
		yourself.	

	process := self newProcessFor: [ 
		bicycle break
	].

	"Act"
	recorder process: process.
	self executeProcess: process.	

	"Assert"
	
	self assert: execution traces size equals: 2.

	self assert: execution traces first isMethod.	
	self assert: execution traces first node selector equals: #break.

	self assert: execution traces second isAssignment.
	self assert: execution traces second node variable name equals: #status.
	
	self assert: bicycle speed equals: 0
]

{ #category : 'tests' }
ScpExecutionRecorderTest >> testMethodWithSuperSend [

	| bicycle execution recorder process |

	"Arrange"
	bicycle := ScpBicycle new.
	execution := ScpExecutionList new.
	
	recorder := ScpExecutionRecorder new
		execution: execution;
		yourself.	

	process := self newProcessFor: [ 
		bicycle drive
	].

	"Act"
	recorder process: process.
	self executeProcess: process.	

	"Assert"
	self assert: execution traces size equals: 3.
	self assert: execution traces first isMethod.	
	self assert: execution traces first node selector equals: #drive.
	self assert: execution traces first node compiledMethod methodClass equals: ScpBicycle.

	self assert: execution traces second isMessage.
	self assert: execution traces second node isSuperSend.
	self assert: execution traces second node selector equals: #drive.

	self assert: execution traces third isMethod.	
	self assert: execution traces third node selector equals: #drive.
	self assert: execution traces third node compiledMethod methodClass equals: ScpVehicle.
]
