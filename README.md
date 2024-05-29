# Scopeo trace recorder

Part of the Scopeo project (a back-in-time debugger), this trace recorder is a tool that allows one to select methods and trace their execution.  

## Installation

```st
Metacello new
  githubUser: 'scopeo-project' project: 'scopeo-trace-recorder' commitish: 'main' path: 'src';
  baseline: 'ScopeoTraceRecorder';
  load
```

## How to use it programmatically ?

The entry point for using the trace recorder programmatically is the class `ScpTraceRecorder`.

To use the class `ScpTraceRecorder`, one must select a **trace source**, i.e. a list of methods for which to generate the traces.  
To facilitate methods selection, we provide the `ScpTraceSourceSelectionBuilder`.  
In the following example the selection builder selects all methods of the package where the class `ScpExampleObjectA` is located.  

```st
| traceSource |
	
traceSource := ScpTraceSourceSelectionBuilder new
  matchPackages: (OTMatcher name: 
	  ScpExampleObjectA package name
  );
  build.
```

Now, one must define a handler which will capture each trace:  
- **Method calls**: which are received from a method external to the trace source.  
- **Messages**: that are sent by any method included in the trace source.  
- **Assignments**: performed inside any method included in the trace source.  
- **Returns**: from any method included in the trace source.  

The handler must be provided to the `ScpTraceRecorder` through the `ScpTraceRecorder >>#storage:` setter.  
Note: this setter may be renamed in the future depending on this project evolution.  
The following example illustrates the `ScpTraceRecorder` set up.  

```st
| traceSource traceRecorder |
	
traceRecorder := ScpTraceRecorder new.
traceRecorder source: traceSource.
traceRecorder storage: ScpTraceListStorage new.
```

Once the `ScpTraceRecorder` is set up, one must run it using following methods:  
- `ScpTraceRecorder >> #switchOn`: to install the hooks which will generate the traces.  
- `ScpTraceRecorder >> #startRecording`: to activate the handler, i.e. start catching the execution traces.	 
- `ScpTraceRecorder >> #switchOff`: to de-activate the handler and remove the hooks.  

```st
| traceSource traceRecorder |
	
traceRecorder switchOn.
traceRecorder startRecording.
traceRecorder switchOff
```
## Known issues

Scenarios which can lead to a crashing image:
- Trying to trace methods from Scopeo's packages.
- Trying to trace methods that are specific to Pharo execution and that should not be rewritten/recompiled, such as:
  - Methods from the `ProtoObject`.
  - Reflective methods of `Object`, i.e. class, slots...
  - Primitive methods.
