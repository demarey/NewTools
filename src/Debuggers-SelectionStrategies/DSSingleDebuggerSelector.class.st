"
I select the first available debugger in the system and try to open a debug session with that debugger.
I do not care about the possible existence of any other debugger.

I am equivalent to the debugger selection strategy encoded in MorphicUIManager prior to the integration of DebuggerSelector.
"
Class {
	#name : #DSSingleDebuggerSelector,
	#superclass : #DSDebuggerSelectionStrategy,
	#category : #'Debuggers-SelectionStrategies'
}

{ #category : #initialization }
DSSingleDebuggerSelector >> initialize [
	super initialize.
	handled := true
]

{ #category : #iterating }
DSSingleDebuggerSelector >> nextDebugger [
	^ debuggers first
]

{ #category : #debuggers }
DSSingleDebuggerSelector >> openDebuggerForSession: aDebugSession [
	[ self nextDebugger debugSession: aDebugSession ]
		on: Error
		do: [ :err | 
			error := err.
			handled := false ]
]