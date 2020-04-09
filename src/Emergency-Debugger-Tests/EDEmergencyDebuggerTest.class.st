Class {
	#name : #EDEmergencyDebuggerTest,
	#superclass : #TestCase,
	#instVars : [
		'ed',
		'session',
		'currentDebuggingAPI'
	],
	#category : #'Emergency-Debugger-Tests'
}

{ #category : #running }
EDEmergencyDebuggerTest >> configureDebugSession [

	"Configure a debug session and moves it to the following stack:
	 EDMockObjectForTests>>m:
	 EDMockObjectForTests>>m:
	 EDMockObjectForTests>>m:
	 EDMockObjectForTests>>m:
	 [ EDMockObjectForTests new m: 10 ] in UndefinedObject>>DoIt"
	
	session stepThrough.
	session stepOver.
	session stepInto.
	session stepOver.
	session stepOver.
	session stepInto.
	session stepOver.
	session stepOver.
	session stepInto.	
	session stepOver.
	session stepOver.
	session stepInto

]

{ #category : #running }
EDEmergencyDebuggerTest >> newEd [
	ed := EDEmergencyDebugger new.
	ed repl: EDMockREPLInterface new.
	ed displayInterface: EDMockDisplayInterface new.
	ed debug: session

]

{ #category : #running }
EDEmergencyDebuggerTest >> setUp [
	| context process |
	super setUp.	
	currentDebuggingAPI := EDEmergencyDebugger debugAPI.
	EDEmergencyDebugger debugAPI: nil.
	context := [ EDMockObjectForTests new m: 10 ] asContext.
	process := Process
		forContext: context
		priority: Processor userInterruptPriority.
	session := DebugSession
		named: 'test session'
		on: process
		startedAt: context.
	self configureDebugSession.
	self newEd
]

{ #category : #running }
EDEmergencyDebuggerTest >> tearDown [
	EDEmergencyDebugger debugAPI: currentDebuggingAPI.
	session terminate.
	super tearDown
]

{ #category : #'debug API' }
EDEmergencyDebuggerTest >> testDebugAPI [
	|api|
	api := EDMockObjectForTests new.
	EDEmergencyDebugger debugAPI: api.
	self assert: EDEmergencyDebugger debugAPI identicalTo: api
	
]

{ #category : #'debug API' }
EDEmergencyDebuggerTest >> testDefaultDebugAPI [
	
	self assert: EDEmergencyDebugger debugAPI identicalTo: EDDebuggingAPI
	
]

{ #category : #setup }
EDEmergencyDebuggerTest >> testIsRunning [
	
	"This is a new Ed, we did not call #debug: so it is not running"
	self deny: EDEmergencyDebugger new isRunning.
	"This Ed, we called #debug: in the test setup so it is running"
	self assert: ed isRunning 
]

{ #category : #setup }
EDEmergencyDebuggerTest >> testTerminate [
	
	ed terminate.
	self deny: ed isRunning 
]