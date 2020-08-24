"
I am a singleton. Use my class side. My class side methods are redirects to the instance methods of my singleton method.
I handle DebugRequests by asking the default UI Manager what to do about them. Typically, the UI manager will decide to open a debugger on the debugRequest, and call my #openDebuggerOnRequest: method to do so.
"
Class {
	#name : #DebuggerSystem,
	#superclass : #Object,
	#category : #'NewTools-DebuggerSelector-Core'
}

{ #category : #'instance creation' }
DebuggerSystem >> availableDebuggers [
	^ (Smalltalk tools debuggers
			sort: #value descending)
			collect: #key
]

{ #category : #helpers }
DebuggerSystem >> debuggerSelectionStrategy [
	"Returns the debugger selection strategy to be used by this DebuggerSystem. This is the value of the corresponding setting"
	^ DSDebuggerSelectionStrategy debuggerSelectionStrategy
		with: self availableDebuggers
]

{ #category : #'default values' }
DebuggerSystem >> defaultUIManager [
	^ UIManager default
]

{ #category : #'handle debug requests' }
DebuggerSystem >> handleDebugRequest: aDebugRequest [
	"A DebugRequest has been submitted. Ask what to do to the default UIManager. Typically, the UIManager will call back my #openDebuggerOnRequest: method to open a debugger"
	[ self defaultUIManager handleDebugRequest: aDebugRequest ] on: Error do: [ self signalDebuggerError: aDebugRequest ]
]

{ #category : #'handle debug requests' }
DebuggerSystem >> handleWarningDebugRequest: aWarningDebugRequest [
	"A WarningDebugRequest has been submitted. Ask what to do to the default UIManager. Typically, the UIManager will call back my #openDebuggerOnRequest: method to open a debugger"
	[ self defaultUIManager handleWarningDebugRequest: aWarningDebugRequest ] on: Error do: [ self signalDebuggerError: aWarningDebugRequest ]
]

{ #category : #'open debugger' }
DebuggerSystem >> openDebuggerOnRequest: aDebugRequest [
	"Prepare the opening of a debugger, and delegate the debugger selection and opening to a strategy"
	| debuggerOpeningStrategy |
	
	self performPreDebugActionsIn: aDebugRequest.
	self spawnNewUIProcessIfNecessary: aDebugRequest.
	debuggerOpeningStrategy := self debuggerSelectionStrategy.
	"Schedule the debugger opening in a deferred UI message to address redraw problems after opening a debugger e.g. from the testrunner."
	self defaultUIManager defer: [ debuggerOpeningStrategy openDebuggerForSession: aDebugRequest debugSession ].
	self suspendDebuggedProcess: aDebugRequest.
]

{ #category : #helpers }
DebuggerSystem >> performPreDebugActionsIn: aDebugRequest [
	"Get the preDebug actions stored in @aDebugRequest. Applies them to the debugSession held by aDebugRequest"
	aDebugRequest computePreDebugActions.
	aDebugRequest preDebugActions do: [ :preDebugAction | preDebugAction value: aDebugRequest debugSession ]
]

{ #category : #'error management' }
DebuggerSystem >> signalDebuggerError: aDebugRequest [
	| failingSession |
	failingSession := aDebugRequest debugSession
		name: self signalDebuggerErrorMessage;
		yourself.
	failingSession signalDebuggerError: aDebugRequest exception
]

{ #category : #'error management' }
DebuggerSystem >> signalDebuggerErrorMessage [
	^ 'DebuggerSystem failure'
]

{ #category : #helpers }
DebuggerSystem >> spawnNewUIProcess [
	"See comment of spawnNewUIProcessIfNecessary:"
	DefaultExecutionEnvironment beActiveDuring: [ self defaultUIManager spawnNewProcess ]
]

{ #category : #helpers }
DebuggerSystem >> spawnNewUIProcessIfNecessary: aDebugRequest [
	"If aDebugRequest is about debugging the UI process, we must create a new UI process to take its place. Because the debugged process will be suspended at some point, and suspending the UI process means freezing the UI of the image"
	(aDebugRequest debugSession isAboutUIProcess) ifTrue: [ self spawnNewUIProcess ].
]

{ #category : #helpers }
DebuggerSystem >> suspendDebuggedProcess: aDebugRequest [
	aDebugRequest process suspend
]