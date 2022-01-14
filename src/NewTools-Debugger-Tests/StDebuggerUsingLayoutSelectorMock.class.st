"
I mock the state of StDebuggerUsingLayoutSelector to test variations in its state.
"
Class {
	#name : #StDebuggerUsingLayoutSelectorMock,
	#superclass : #StDebuggerLayoutSelector,
	#instVars : [
		'withDebuggerExtensions',
		'withActivatedExtensions'
	],
	#category : #'NewTools-Debugger-Tests-Utils'
}

{ #category : #initialization }
StDebuggerUsingLayoutSelectorMock class >> initializeWithExtensionsAllActivated [
	^self new initializeWithExtensionsAllActivated
]

{ #category : #initialization }
StDebuggerUsingLayoutSelectorMock class >> initializeWithExtensionsNoneActivated [
	^self new initializeWithExtensionsNoneActivated
]

{ #category : #initialization }
StDebuggerUsingLayoutSelectorMock class >> initializeWithoutExtensionsAllActivated [
	^self new initializeWithoutExtensionsAllActivated
]

{ #category : #initialization }
StDebuggerUsingLayoutSelectorMock class >> initializeWithoutExtensionsNoneActivated [
	^self new initializeWithoutExtensionsNoneActivated
]

{ #category : #accessing }
StDebuggerUsingLayoutSelectorMock >> activateDebuggerExtensions [
	^withDebuggerExtensions 
]

{ #category : #accessing }
StDebuggerUsingLayoutSelectorMock >> availableLayoutSelectors [
	^ StDebugger availableLayoutSelectors
		add: self nonDefaultSelector;
		yourself
]

{ #category : #specs }
StDebuggerUsingLayoutSelectorMock >> columnInspectorsSpec [
]

{ #category : #accessing }
StDebuggerUsingLayoutSelectorMock >> debuggerClass [ 	
	^self
]

{ #category : #accessing }
StDebuggerUsingLayoutSelectorMock >> extensionToolsClasses [
	^{}
]

{ #category : #accessing }
StDebuggerUsingLayoutSelectorMock >> hasAnyActivatedExtension: anObject [
	^ withActivatedExtensions
]

{ #category : #initialization }
StDebuggerUsingLayoutSelectorMock >> initializeWithExtensionsAllActivated [
	withDebuggerExtensions := true.
	withActivatedExtensions := true
]

{ #category : #initialization }
StDebuggerUsingLayoutSelectorMock >> initializeWithExtensionsNoneActivated [
	withDebuggerExtensions := true.
	withActivatedExtensions := false
]

{ #category : #initialization }
StDebuggerUsingLayoutSelectorMock >> initializeWithoutExtensionsAllActivated [
	withDebuggerExtensions := false.
	withActivatedExtensions := true
]

{ #category : #initialization }
StDebuggerUsingLayoutSelectorMock >> initializeWithoutExtensionsNoneActivated [
	withDebuggerExtensions := false.
	withActivatedExtensions := false
]

{ #category : #accessing }
StDebuggerUsingLayoutSelectorMock >> nonDefaultSelector [
	^#nonDefaultSelector
]
