"
I take as input a sorted list of debuggers and a debug session.
I will try to open the debug session with the first applicable debugger in this list.

If this first applicable debugger encounters an error, I will either try the next applicable debugger or if I am configured to handle debugger errors (see handlesDebuggerErrors:) I will raise a DebuggerFailure exception.

When I try to open a debug session created from a DebuggerFailure, I exclude the debugger that produced the debugger failure from my debugger list.

When I succeeded to open a debugger, my instance variable ""handled"" becomes true. 
If I failed to find any debugger, or to open the debug session with any debugger, ""handled"" stays false. This is the responsibility of my clients to deal with this situation (i.e., the system was unable to open a debugger).
"
Class {
	#name : #DSDebuggerSelector,
	#superclass : #DSDebuggerSelectionStrategy,
	#instVars : [
		'handlesDebuggerErrors'
	],
	#classInstVars : [
		'handleDebuggerErrors'
	],
	#category : #'Debuggers-SelectionStrategies'
}

{ #category : #settings }
DSDebuggerSelector class >> handleDebuggerErrors [
	^ handleDebuggerErrors ifNil: [ handleDebuggerErrors := false ]
]

{ #category : #settings }
DSDebuggerSelector class >> handleDebuggerErrors: aBoolean [
	handleDebuggerErrors := aBoolean
]

{ #category : #settings }
DSDebuggerSelector class >> handleDebuggerErrorsSettingsOn: aBuilder [
	<systemsettings>
	(aBuilder setting: #handleDebuggerErrors)
		label: 'Handle debugger errors';
		target: self;
		default: false;
		parent: #debugging;
		description: 'Try to debug debugger errors when they occur.'
]

{ #category : #accessing }
DSDebuggerSelector >> debuggers: aCollection [
	debuggers := Stack newFrom: aCollection
]

{ #category : #accessing }
DSDebuggerSelector >> handlesDebuggerErrors [
	^ handlesDebuggerErrors
		ifNil: [ handlesDebuggerErrors := self class handleDebuggerErrors ]
]

{ #category : #accessing }
DSDebuggerSelector >> handlesDebuggerErrors: aBoolean [ 
	handlesDebuggerErrors := aBoolean
]

{ #category : #iterating }
DSDebuggerSelector >> nextDebugger [
	^ debuggers pop
]

{ #category : #debuggers }
DSDebuggerSelector >> nextDebuggerForSession: aDebugSession [
	| debugger |
	debugger := self nextDebugger.
	[ (debugger handlesContext: aDebugSession context)
		and: [ aDebugSession exception isHandleableBy: debugger ] ]
		whileFalse: [ debugger := self nextDebugger ].
	^ debugger
]

{ #category : #debuggers }
DSDebuggerSelector >> openDebuggerForSession: aDebugSession [
	handled := false.
	[ handled or:[self debuggers isEmpty ]]
		whileFalse: [ self
				tryOpen: aDebugSession
				with: (self nextDebuggerForSession: aDebugSession) ]
]

{ #category : #debuggers }
DSDebuggerSelector >> tryOpen: aDebugSession with: aDebugger [
	[ aDebugger debugSession: aDebugSession.
	handled := true ]
		on: Error , UnhandledException
		do: [ :err | 
			error := err.
			(self handlesDebuggerErrors
				and: [ aDebugSession exception isDebuggerFailure not ])
				ifTrue: [ (DebuggerFailure of: aDebugger on: err) signal ] ]
]