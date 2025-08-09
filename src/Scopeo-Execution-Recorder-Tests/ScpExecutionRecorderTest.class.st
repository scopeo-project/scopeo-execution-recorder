Class {
	#name : 'ScpExecutionRecorderTest',
	#superclass : 'TestCase',
	#instVars : [
		'semaphore',
		'instVar',
		'line'
	],
	#category : 'Scopeo-Execution-Recorder-Tests',
	#package : 'Scopeo-Execution-Recorder-Tests'
}

{ #category : 'as yet unclassified' }
ScpExecutionRecorderTest >> methodThatRequiresAnEnsureBlock [

	| block |
	block := [ thisContext sourceNode ].
	block value.
	^ block sourceNode.
]

{ #category : 'as yet unclassified' }
ScpExecutionRecorderTest >> methodUntracked [
	
	^ 42 asString
]

{ #category : 'as yet unclassified' }
ScpExecutionRecorderTest >> methodUntrackedWithTrackedBlock: aBlock [
	
	^ aBlock value
]

{ #category : 'as yet unclassified' }
ScpExecutionRecorderTest >> methodWithArgument: anArgument [

	^ anArgument
]

{ #category : 'as yet unclassified' }
ScpExecutionRecorderTest >> methodWithAssignment [

	instVar := 42
]

{ #category : 'as yet unclassified' }
ScpExecutionRecorderTest >> methodWithAssignmentOfMessageResult [
	
	line := GLine through: 1 , 2 and: 3 , 5
]

{ #category : 'as yet unclassified' }
ScpExecutionRecorderTest >> methodWithBlockAndMessage [
	
	| block |
	
	block := [ 42 asString ].
	block value.
	
	^ 42 asString
	
]

{ #category : 'as yet unclassified' }
ScpExecutionRecorderTest >> methodWithEscapingTrackedBlock [
	
	self methodUntrackedWithTrackedBlock: [ 42 asString ].
	^ 42 asString
	
]

{ #category : 'as yet unclassified' }
ScpExecutionRecorderTest >> methodWithEscapingTrackedBlockAndIfNilBranch [
	
	self methodUntrackedWithTrackedBlock: [ nil 
		ifNil: [ 42 asString  ] 
	].
	^ 52 asString
	
]

{ #category : 'as yet unclassified' }
ScpExecutionRecorderTest >> methodWithException [

	self error: 'Exception'
]

{ #category : 'as yet unclassified' }
ScpExecutionRecorderTest >> methodWithIfNilBranch [

	"This type of method can contain inlinings which can break the recorder"
	
	nil 
		ifNil: [ 42 asString  ] 
		ifNotNil: [ "Never happens" ].
		
	^ 52 asString
]

{ #category : 'as yet unclassified' }
ScpExecutionRecorderTest >> methodWithMultipleMessages [

	42 asString.
	52 asString
	
]

{ #category : 'as yet unclassified' }
ScpExecutionRecorderTest >> methodWithObjectInstanciation [

	ScpExecutionRecorderTestObject new
]

{ #category : 'as yet unclassified' }
ScpExecutionRecorderTest >> setUp [

	super setUp.
	
	semaphore := Semaphore new
]

{ #category : 'as yet unclassified' }
ScpExecutionRecorderTest >> testMethodThatRequiresAnEnsureBlock [

	| execution |
	
	"Act"
	execution := ScpExecutionRecorder 
		recordBlock: [ self methodThatRequiresAnEnsureBlock ]
		as: ScpExecutionRecordTree.

	"Assert"
	self assert: execution methods isNotEmpty.

	self assert: execution methods size equals: 2.
	self assert: execution methods first isMethod.
	self assert: execution methods first object identicalTo: self.

	self assert: execution methods first children isNotEmpty.
	self assert: execution methods first children size equals: 2.
	
	self assert: execution methods first children first isMessage.
	self assert: execution methods first children first receiver isBlock.
	self assert: execution methods first children first node selector equals: #value.
	self assert: execution methods first children first node arguments isEmpty.
	
	self assert: execution methods first children second isMessage.
	self assert: execution methods first children second receiver isBlock.
	self assert: execution methods first children second node selector equals: #sourceNode.
	self assert: execution methods first children second node arguments isEmpty.
]

{ #category : 'tests' }
ScpExecutionRecorderTest >> testMethodUntracked [

	| execution |

	"Act"
	execution := ScpExecutionRecorder 
		recordBlock: [ self methodUntracked ]
		as: ScpExecutionRecordTree
		ignore: [:m | m = (self class >> #methodUntracked) ].
		
	"Assert"
	self assert: execution methods isNotEmpty.

	self assert: execution methods size equals: 2.
	self assert: execution methods first isTracked not.
	self assert: execution methods first object identicalTo: self
]

{ #category : 'tests' }
ScpExecutionRecorderTest >> testMethodUntrackedWithTrackedBlock [

	| execution |

	"Act"
	execution := ScpExecutionRecorder 
		recordBlock: [ self methodWithEscapingTrackedBlock ]
		as: ScpExecutionRecordTree
		ignore: [:m | 
			m selector = #methodUntrackedWithTrackedBlock: or: [ 
				m selector = #asString 
			] 
		].

	"Assert"
	self assert: execution methods isNotEmpty.
	self assert: execution methods size equals: 2.
	
	self assert: execution methods first isMethod.
	self assert: execution methods first isTracked.
	self assert: execution methods first children isNotEmpty.
	self assert: execution methods first children size equals: 2.
	
	self assert: execution methods first children first isMessage.
	self assert: execution methods first children first children isNotEmpty.
	
	self assert: execution methods first children first children first isMethod.
	self assert: execution methods first children first children first isTracked not.
	
	self assert: execution methods first children first children first children isNotEmpty.
	self assert: execution methods first children first children first children first isMessage.
	self assert: execution methods first children first children first children first node selector equals: #asString
]

{ #category : 'tests' }
ScpExecutionRecorderTest >> testMethodUntrackedWithTrackedBlockAndIfNilBranch [

	| execution |

	"Act"
	execution := ScpExecutionRecorder 
		recordBlock: [ self methodWithEscapingTrackedBlockAndIfNilBranch ]
		as: ScpExecutionRecordTree
		ignore: [:m | m selector = #methodUntrackedWithTrackedBlock: ].

	"Assert"
	self assert: execution methods isNotEmpty.
	self assert: execution methods size equals: 2.
	
	self assert: execution methods first isMethod.
	self assert: execution methods first isTracked.
	self assert: execution methods first children isNotEmpty.
	self assert: execution methods first children size equals: 2.
	
	self assert: execution methods first children first isMessage.
	self assert: execution methods first children first children isNotEmpty.
	
	self assert: execution methods first children first children first isMethod.
	self assert: execution methods first children first children first isTracked not.
	
	self assert: execution methods first children first children first children isNotEmpty.
	self assert: execution methods first children first children first children first isMessage.
	self assert: execution methods first children first children first children first node selector equals: #ifNil:.
	
	self assert: execution methods first children second isMessage.
	self assert: execution methods first children second node selector equals: #asString.
]

{ #category : 'tests' }
ScpExecutionRecorderTest >> testMethodWithArgument [

	| execution |

	"Act"
	execution := ScpExecutionRecorder 
		recordBlock: [ self methodWithArgument: 42 ]
		as: ScpExecutionRecordTree.
		
	"Assert"
	self assert: execution methods isNotEmpty.

	self assert: execution methods size equals: 2.
	self assert: execution methods first object identicalTo: self.

	self assert: execution methods first arguments isNotEmpty.
	self assert: execution methods first arguments size equals: 1.
	self assert: execution methods first arguments first identicalTo: 42
]

{ #category : 'tests' }
ScpExecutionRecorderTest >> testMethodWithAssignment [

	| execution |

	"Act"
	execution := ScpExecutionRecorder 
		recordBlock: [ self methodWithAssignment ]
		as: ScpExecutionRecordTree.
		
	"Assert"
	self assert: execution methods isNotEmpty.

	self assert: execution methods size equals: 2.
	self assert: execution methods first isMethod.
	self assert: execution methods first object identicalTo: self.

	self assert: execution methods first children isNotEmpty.
	self assert: execution methods first children first oldValue isNil.
	self assert: execution methods first children first newValue equals: 42.
	self assert: execution methods first children first object identicalTo: self
]

{ #category : 'as yet unclassified' }
ScpExecutionRecorderTest >> testMethodWithAssignmentOfMessageResult [
		
	| execution |
	
	"Act"
	execution := ScpExecutionRecorder 
		recordBlock: [ self methodWithAssignmentOfMessageResult ]
		as: ScpExecutionRecordTree.

	"Assert"
	self assert: execution methods isNotEmpty.

	self assert: execution methods size equals: 2.
	self assert: execution methods first isMethod.
	self assert: execution methods first object identicalTo: self.

	self assert: execution methods first children isNotEmpty.
	self assert: execution methods first children size equals: 4.
	
	self assert: execution methods first children first isMessage.
	self assert: execution methods first children first receiver equals: 1.
	self assert: execution methods first children first node selector equals: #,.
	self assert: execution methods first children first arguments first equals: 2.
	
	self assert: execution methods first children second isMessage.
	self assert: execution methods first children second receiver equals: 3.
	self assert: execution methods first children second node selector equals: #,.
	self assert: execution methods first children second arguments first equals: 5.
	
	self assert: execution methods first children third isMessage.
	self assert: execution methods first children third sender equals: self.
	self assert: execution methods first children third receiver equals: GLine.
	self assert: execution methods first children third node selector equals: #through:and:.
	
	self assert: execution methods first children fourth isAssignment
]

{ #category : 'as yet unclassified' }
ScpExecutionRecorderTest >> testMethodWithBlockAndMessage [
	
	| execution |
	
	"Act"
	execution := ScpExecutionRecorder 
		recordBlock: [ self methodWithBlockAndMessage ]
		as: ScpExecutionRecordTree.
	
	"Assert"
	self assert: execution methods isNotEmpty.

	self assert: execution methods size equals: 2.
	self assert: execution methods first isMethod.
	self assert: execution methods first object identicalTo: self.

	self assert: execution methods first children isNotEmpty.
	self assert: execution methods first children size equals: 2.
	
	self assert: execution methods first children first isMessage.
	self assert: execution methods first children first node selector equals: #value.
	
	self assert: execution methods first children second isMessage.
	self assert: execution methods first children second node selector equals: #asString
]

{ #category : 'tests' }
ScpExecutionRecorderTest >> testMethodWithException [

	| block |

	"Arrange"
	block := [
		ScpExecutionRecorder 
			recordBlock: [ self methodWithException ]
			as: ScpExecutionRecordTree 
	].	  
	
	"Assert"
	self should: block raise: Error description: 'Exception'.
]

{ #category : 'as yet unclassified' }
ScpExecutionRecorderTest >> testMethodWithIfNilBranch [
	
	| execution |
	
	"Act"
	execution := ScpExecutionRecorder 
		recordBlock: [ self methodWithIfNilBranch ]
		as: ScpExecutionRecordTree.

	"Assert"
	self assert: execution methods isNotEmpty.

	self assert: execution methods size equals: 2.
	self assert: execution methods first isMethod.
	self assert: execution methods first object identicalTo: self.

	self assert: execution methods first children isNotEmpty.
	self assert: execution methods first children size equals: 2.
	
	self assert: execution methods first children first isMessage.
	self assert: execution methods first children first receiver identicalTo: nil.
	self assert: execution methods first children first node selector equals: #ifNil:ifNotNil:.
	self assert: execution methods first children first node arguments size equals: 2.
	self assert: execution methods first children first node arguments first isBlock.
	self assert: execution methods first children first node arguments second isBlock.
	
	self assert: execution methods first children second isMessage.
	self assert: execution methods first children second receiver identicalTo: 52.
	self assert: execution methods first children second node selector equals: #asString.
	self assert: execution methods first children second node arguments isEmpty
]

{ #category : 'tests' }
ScpExecutionRecorderTest >> testMethodWithMultipleMessages [

	| execution |

	"Act"
	execution := ScpExecutionRecorder 
		recordBlock: [ self methodWithMultipleMessages ]
		as: ScpExecutionRecordTree.
		
	"Assert"
	self assert: execution methods isNotEmpty.

	self assert: execution methods size equals: 2.
	self assert: execution methods first isMethod.
	self assert: execution methods first object identicalTo: self.

	self assert: execution methods first children isNotEmpty.
	self assert: execution methods first children size equals: 2.
	
	self assert: execution methods first children first isMessage.
	self assert: execution methods first children first receiver equals: 42.
	
	self assert: execution methods first children second isMessage.
	self assert: execution methods first children second receiver equals: 52
]

{ #category : 'tests' }
ScpExecutionRecorderTest >> testMethodWithObjectInstanciation [

	| execution |

	"Act"
	execution := ScpExecutionRecorder 
		recordBlock: [ self methodWithObjectInstanciation ]
		as: ScpExecutionRecordTree.

	"Assert"
	self assert: execution methods isNotEmpty.

	self assert: execution methods size equals: 2.
	self assert: execution methods first object identicalTo: self.

	self assert: execution methods first children first children first children second node selector equals: #initialize
]
