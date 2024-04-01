Class {
	#name : #ScpExampleObject,
	#superclass : #Object,
	#category : #'Scopeo-TraceRecorder-TestObjects'
}

{ #category : #'as yet unclassified' }
ScpExampleObject >> exampleSuperCall: aValue [

	(ScpInstrumentationRegistry instance at: 837734912)
		method: #exampleSuperCall:
		from: thisContext sender receiver
		to: self
		with: { aValue }.
	(ScpInstrumentationRegistry instance at: 837734912)
		message: #method:from:to:with:
		from: self
		to: ((ScpInstrumentationRegistry instance at: 837734912)
				 message: #at:
				 from: self
				 to: ((ScpInstrumentationRegistry instance at: 837734912)
						  message: #instance
						  from: self
						  to: ScpInstrumentationRegistry
						  with: {  })
				 with: { 188855296 })
		with: {
				#exampleSuperCall:.
				((ScpInstrumentationRegistry instance at: 837734912)
					 message: #receiver
					 from: self
					 to: ((ScpInstrumentationRegistry instance at: 837734912)
							  message: #sender
							  from: self
							  to: thisContext
							  with: {  })
					 with: {  }).
				self.
				{ aValue } }.
	(ScpInstrumentationRegistry instance at: 837734912)
		message: #method:from:to:with:
		from: self
		to: ((ScpInstrumentationRegistry instance at: 837734912)
				 message: #at:
				 from: self
				 to: ((ScpInstrumentationRegistry instance at: 837734912)
						  message: #instance
						  from: self
						  to: ScpInstrumentationRegistry
						  with: {  })
				 with: { 188855296 })
		with: {
				#method:from:to:with:.
				self.
				((ScpInstrumentationRegistry instance at: 837734912)
					 message: #method:from:to:with:
					 from: self
					 to: ((ScpInstrumentationRegistry instance at: 837734912)
							  message: #at:
							  from: self
							  to: ((ScpInstrumentationRegistry instance at: 837734912)
									   message: #instance
									   from: self
									   to: ScpInstrumentationRegistry
									   with: {  })
							  with: { 188855296 })
					 with: {
							 #at:.
							 self.
							 ((ScpInstrumentationRegistry instance at: 837734912)
								  message: #method:from:to:with:
								  from: self
								  to: ((ScpInstrumentationRegistry instance at: 837734912)
										   message: #at:
										   from: self
										   to: ((ScpInstrumentationRegistry instance at: 837734912)
												    message: #instance
												    from: self
												    to: ScpInstrumentationRegistry
												    with: {  })
										   with: { 188855296 })
								  with: {
										  #instance.
										  self.
										  ScpInstrumentationRegistry.
										  {  } }).
							 { 410405888 } }).
				{
					#exampleSuperCall:.
					((ScpInstrumentationRegistry instance at: 837734912)
						 message: #method:from:to:with:
						 from: self
						 to: ((ScpInstrumentationRegistry instance at: 837734912)
								  message: #at:
								  from: self
								  to: ((ScpInstrumentationRegistry instance at: 837734912)
										   message: #instance
										   from: self
										   to: ScpInstrumentationRegistry
										   with: {  })
								  with: { 188855296 })
						 with: {
								 #receiver.
								 self.
								 ((ScpInstrumentationRegistry instance at: 837734912)
									  message: #method:from:to:with:
									  from: self
									  to: ((ScpInstrumentationRegistry instance at: 837734912)
											   message: #at:
											   from: self
											   to:
												   ((ScpInstrumentationRegistry instance at: 837734912)
													    message: #instance
													    from: self
													    to: ScpInstrumentationRegistry
													    with: {  })
											   with: { 188855296 })
									  with: {
											  #sender.
											  self.
											  thisContext.
											  {  } }).
								 {  } }).
					self.
					{ aValue } } }.

	^ (ScpInstrumentationRegistry instance at: 837734912) methodReturn:
		  ((ScpInstrumentationRegistry instance at: 837734912)
			   message: #methodReturn:
			   from: self
			   to: ((ScpInstrumentationRegistry instance at: 837734912)
					    message: #at:
					    from: self
					    to: ((ScpInstrumentationRegistry instance at: 837734912)
							     message: #instance
							     from: self
							     to: ScpInstrumentationRegistry
							     with: {  })
					    with: { 188855296 })
			   with: { ((ScpInstrumentationRegistry instance at: 837734912)
					    message: #method:from:to:with:
					    from: self
					    to: ((ScpInstrumentationRegistry instance at: 837734912)
							     message: #at:
							     from: self
							     to: ((ScpInstrumentationRegistry instance at: 837734912)
									      message: #instance
									      from: self
									      to: ScpInstrumentationRegistry
									      with: {  })
							     with: { 188855296 })
					    with: {
							    #methodReturn:.
							    self.
							    ((ScpInstrumentationRegistry instance at: 837734912)
								     message: #method:from:to:with:
								     from: self
								     to: ((ScpInstrumentationRegistry instance at: 837734912)
										      message: #at:
										      from: self
										      to:
											      ((ScpInstrumentationRegistry instance at: 837734912)
												       message: #instance
												       from: self
												       to: ScpInstrumentationRegistry
												       with: {  })
										      with: { 188855296 })
								     with: {
										     #at:.
										     self.
										     ((ScpInstrumentationRegistry instance at: 837734912)
											      message: #method:from:to:with:
											      from: self
											      to:
												      ((ScpInstrumentationRegistry instance at: 837734912)
													       message: #at:
													       from: self
													       to:
														       ((ScpInstrumentationRegistry instance at:
															         837734912)
															        message: #instance
															        from: self
															        to: ScpInstrumentationRegistry
															        with: {  })
													       with: { 188855296 })
											      with: {
													      #instance.
													      self.
													      ScpInstrumentationRegistry.
													      {  } }).
										     { 410405888 } }).
							    { aValue } }) })
]
