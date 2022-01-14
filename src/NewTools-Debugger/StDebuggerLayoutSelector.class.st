"
I select and returns the layout selector to be used by the StDebugger presenter.
	Two cases:
	- current selector exists or is not valid: returns default layout selector with debugger extensions
	- current selector exists: select a version with or without debugger extensions
	
Three cases:
	- custom selector: returned as is
	- selector is one of the display strategy with or without debugger extensions
		- extensions activated: force return of layout selector with extensions
		- extensions not activated: force return of layout selector without extensions
		
	Checks performed to tell if extensions are activated:
		- activateDebuggerExtensions must be true
		- AND at least one existing extension class is activated as debugger extension
"
Class {
	#name : #StDebuggerLayoutSelector,
	#superclass : #Object,
	#instVars : [
		'layoutSelector'
	],
	#category : #'NewTools-Debugger-Model'
}

{ #category : #accessing }
StDebuggerLayoutSelector class >> debuggerClass [

	^ StDebugger
]

{ #category : #'specs - default selectors' }
StDebuggerLayoutSelector class >> defaultDebuggerWithExtensionLayoutSelector [

	^ #debuggerWithExtensionsLayout
]

{ #category : #'specs - default selectors' }
StDebuggerLayoutSelector class >> defaultDebuggerWithoutExtensionLayoutSelector [

	^ #debuggerWithoutExtensionsLayout
]

{ #category : #'instance creation' }
StDebuggerLayoutSelector class >> defaultSelector [

	^ self on: self defaultDebuggerWithExtensionLayoutSelector
]

{ #category : #'instance creation' }
StDebuggerLayoutSelector class >> on: aSelector [

	^ self new layoutSelector: aSelector
]

{ #category : #accessing }
StDebuggerLayoutSelector >> debuggerClass [

	^ self class debuggerClass
]

{ #category : #testing }
StDebuggerLayoutSelector >> isDefaultSelector: aSelector [

	^ { self class defaultDebuggerWithExtensionLayoutSelector.
		 self class defaultDebuggerWithoutExtensionLayoutSelector } 
		  includes: aSelector
]

{ #category : #'specs - default selector' }
StDebuggerLayoutSelector >> layoutSelector [
	^ layoutSelector
]

{ #category : #accessing }
StDebuggerLayoutSelector >> layoutSelector: anObject [
	layoutSelector := anObject
]

{ #category : #'specs - selectors' }
StDebuggerLayoutSelector >> selectExtensionActivationSpecFrom: aDefaultSpecSelector [

	"Altered depending on the current configuration of the debugger extensions.
	The selection just adds or remove the extensions from the spec selector"

	self class defaultDebuggerWithoutExtensionLayoutSelector
	= aDefaultSpecSelector ifTrue: [ ^ aDefaultSpecSelector ].
	^ self
		  selectorForDebuggerStatus:
		  self debuggerClass activateDebuggerExtensions
		  extensionsStatus: (self debuggerClass hasAnyActivatedExtension:
				   self debuggerClass extensionToolsClasses)
]

{ #category : #'specs - selectors' }
StDebuggerLayoutSelector >> selectLayoutSelector [
	"Sets and returns the spec selector to be use by the presenter.
	Two cases:
	- current selector exists or is not valid: returns default spec selector with extensions
	- current selector exists: select a version with or without debugger extensions"

	| selector |
	selector := (self debuggerClass availableLayoutSelectors includes: layoutSelector)
		ifTrue: [ layoutSelector ]
		ifFalse: [ self class defaultDebuggerWithExtensionLayoutSelector ].
	(self isDefaultSelector: selector) ifFalse:[^selector].
	^ self selectExtensionActivationSpecFrom: selector
]

{ #category : #'specs - selectors' }
StDebuggerLayoutSelector >> selectorForDebuggerStatus: debuggerExtensionsActivated extensionsStatus: debuggerHasExtensions [
	"This is only relevant in the case we use default StDebugger specs for which the extension column can be configured in settings"

	^ (debuggerExtensionsActivated and: [ debuggerHasExtensions ])
		ifTrue: [ self class defaultDebuggerWithExtensionLayoutSelector ]
		ifFalse: [ self class defaultDebuggerWithoutExtensionLayoutSelector ]
]
