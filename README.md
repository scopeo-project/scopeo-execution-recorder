# Scopeo execution recorder

![Unit tests badge](https://img.shields.io/github/actions/workflow/status/scopeo-project/scopeo-execution-recorder/tests.yml?label=Unit%20tests&branch=main)

A library to record a method execution in a given (or automatically created) process and reify it as a call graph in Pharo.

## How to install?

```st
Metacello new
  githubUser: 'scopeo-project' project: 'scopeo-execution-recorder'
  commitish: 'main' path: 'src';
  baseline: 'ScopeoExecutionRecorder';
  load
```

## How to use it?

*More information to come*

Simply create an instance of the recorder.  
If needed, specify a block which must return true whenever the recorder should ignore the execution details of the method in argument.  

Start the recorded execution by using the method `recordBlock: aBlock`:

```st
| recorder |

recorder := ScpExecutionRecorder new 
	ignore: [ :m | 
		(m package name beginsWith: #Morph)
		or: [ m package name beginsWith: #FreeType ]
	];
	recordBlock: [ Transcript open ];
  yourself.

recorder execution inspect. "Inspect the traces. (More to come)"
```

Or attach the newly created recorder to an existing process and resume the latter process:

```st
| recorder |

recorder := ScpExecutionRecorder new 
  attachToProcess: anExistingProcess;
  yourself.

anExistingProcess resume.

recorder execution inspect. "Inspect the traces. (More to come)"

```

Or attach to the context of a suspended process and resume that process:

```st
| recorder | 

recorder := ScpExecutionRecorder new 
  attachToContext: anExistingProcess suspendedContext;
  yourself

anExistingProcess resume.

recorder execution inspect. "Inspect the traces. (More to come)"
```