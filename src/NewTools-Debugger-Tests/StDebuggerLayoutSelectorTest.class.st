Class {
	#name : #StDebuggerLayoutSelectorTest,
	#superclass : #TestCase,
	#instVars : [
		'specSelector'
	],
	#category : #'NewTools-Debugger-Tests-Model'
}

{ #category : #helpers }
StDebuggerLayoutSelectorTest >> defaultSelectorWithExtensions [
	^ StDebuggerLayoutSelector
		defaultDebuggerWithExtensionLayoutSelector
]

{ #category : #helpers }
StDebuggerLayoutSelectorTest >> defaultSelectorWithoutExtensions [
	^ StDebuggerLayoutSelector
		defaultDebuggerWithoutExtensionLayoutSelector
]

{ #category : #running }
StDebuggerLayoutSelectorTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	super setUp.
	specSelector := StDebuggerLayoutSelector new
]

{ #category : #'tests - spec' }
StDebuggerLayoutSelectorTest >> testCustomSelectExtensionActivationSpecFrom [
	| customSelector mockSelector |
	customSelector := #anySelector.
	mockSelector := StDebuggerUsingLayoutSelectorMock new.
	
	mockSelector initializeWithExtensionsNoneActivated.
	self
		assert: (mockSelector selectExtensionActivationSpecFrom: customSelector)
		equals: self defaultSelectorWithoutExtensions.
		
	mockSelector initializeWithoutExtensionsNoneActivated.
	self
		assert: (mockSelector selectExtensionActivationSpecFrom: customSelector)
		equals: self defaultSelectorWithoutExtensions.
		
	mockSelector initializeWithoutExtensionsAllActivated.
	self
		assert: (mockSelector selectExtensionActivationSpecFrom: customSelector)
		equals: self defaultSelectorWithoutExtensions.
		
	mockSelector initializeWithExtensionsAllActivated.		
	self
		assert: (mockSelector selectExtensionActivationSpecFrom: customSelector)
		equals: self defaultSelectorWithExtensions
]

{ #category : #'tests - spec' }
StDebuggerLayoutSelectorTest >> testCustomSelectSpecSelector [
	| customSelector mockSelector |
	mockSelector := StDebuggerUsingLayoutSelectorMock new.
	customSelector := mockSelector nonDefaultSelector.	
	mockSelector layoutSelector: customSelector.
	
	mockSelector initializeWithExtensionsNoneActivated.
	self assert: mockSelector selectLayoutSelector equals: customSelector.
	
	mockSelector initializeWithoutExtensionsNoneActivated.
	self assert: mockSelector selectLayoutSelector equals: customSelector.
	
	mockSelector initializeWithoutExtensionsAllActivated.
	self assert: mockSelector selectLayoutSelector equals: customSelector.
	
	mockSelector initializeWithExtensionsAllActivated.	
	self assert: mockSelector selectLayoutSelector equals: customSelector
]

{ #category : #'tests - spec' }
StDebuggerLayoutSelectorTest >> testDebuggerClass [
	self assert: specSelector debuggerClass identicalTo: StDebugger
]

{ #category : #'tests - spec' }
StDebuggerLayoutSelectorTest >> testDefaultSelector [
	self
		assert: StDebuggerLayoutSelector defaultSelector layoutSelector
		equals: specSelector class defaultDebuggerWithExtensionLayoutSelector
]

{ #category : #'tests - spec' }
StDebuggerLayoutSelectorTest >> testIsDefaultSelector [
	self deny: (specSelector isDefaultSelector: #anySelector).
	self
		assert:
			(specSelector
				isDefaultSelector: specSelector class defaultDebuggerWithExtensionLayoutSelector).
	self
		assert:
			(specSelector
				isDefaultSelector: specSelector class defaultDebuggerWithoutExtensionLayoutSelector)
]

{ #category : #'tests - spec' }
StDebuggerLayoutSelectorTest >> testNilSelectSpecSelector [
	| withExtensionSelector withoutExtensionSelector  mockSelector |
	withExtensionSelector := self defaultSelectorWithExtensions.
	withoutExtensionSelector := self defaultSelectorWithoutExtensions.	
	mockSelector := StDebuggerUsingLayoutSelectorMock new.
	mockSelector layoutSelector: nil.
	
	mockSelector	initializeWithExtensionsNoneActivated.	
	self assert: mockSelector selectLayoutSelector equals: withoutExtensionSelector.
	
	mockSelector initializeWithoutExtensionsNoneActivated.	
	self assert: mockSelector selectLayoutSelector equals: withoutExtensionSelector.
	
	mockSelector initializeWithoutExtensionsAllActivated.
	self assert: mockSelector selectLayoutSelector equals: withoutExtensionSelector.
	
	mockSelector initializeWithExtensionsAllActivated.		
	self assert: mockSelector selectLayoutSelector equals: withExtensionSelector
]

{ #category : #'tests - spec' }
StDebuggerLayoutSelectorTest >> testSelectExtensionActivationSpecFrom [
	| withExtensionSelector withoutExtensionSelector mockSelector |
	withExtensionSelector := self defaultSelectorWithExtensions.
	withoutExtensionSelector := self defaultSelectorWithoutExtensions.	
	mockSelector := StDebuggerUsingLayoutSelectorMock new.
		
	mockSelector	initializeWithExtensionsNoneActivated.		
	self
		assert: (mockSelector selectExtensionActivationSpecFrom: withExtensionSelector)
		equals: withoutExtensionSelector.
	self
		assert: (mockSelector selectExtensionActivationSpecFrom: withoutExtensionSelector)
		equals: withoutExtensionSelector.
		
	mockSelector initializeWithoutExtensionsNoneActivated.
	self
		assert: (mockSelector selectExtensionActivationSpecFrom: withExtensionSelector)
		equals: withoutExtensionSelector.
	self
		assert: (mockSelector selectExtensionActivationSpecFrom: withoutExtensionSelector)
		equals: withoutExtensionSelector.
		
	mockSelector initializeWithoutExtensionsAllActivated.
	self
		assert: (mockSelector selectExtensionActivationSpecFrom: withExtensionSelector)
		equals: withoutExtensionSelector.
	self
		assert: (mockSelector selectExtensionActivationSpecFrom: withoutExtensionSelector)
		equals: withoutExtensionSelector.
		
	mockSelector initializeWithExtensionsAllActivated.
	self
		assert: (mockSelector selectExtensionActivationSpecFrom: withExtensionSelector)
		equals: withExtensionSelector.
	self
		assert: (mockSelector selectExtensionActivationSpecFrom: withoutExtensionSelector)
		equals: withoutExtensionSelector.
]

{ #category : #'tests - spec' }
StDebuggerLayoutSelectorTest >> testSelectNonDefaultSpecSelector [
	| nonDefaultSelector mockSelector |		
	mockSelector := StDebuggerUsingLayoutSelectorMock new.	
	nonDefaultSelector := mockSelector nonDefaultSelector.
	mockSelector layoutSelector: nonDefaultSelector.	
		
	mockSelector	initializeWithExtensionsNoneActivated.
	self
		assert: mockSelector selectLayoutSelector
		equals: nonDefaultSelector.		
		
	mockSelector initializeWithoutExtensionsNoneActivated.
	self
		assert: mockSelector selectLayoutSelector
		equals: nonDefaultSelector.
				
	mockSelector initializeWithoutExtensionsAllActivated.
	self
		assert: mockSelector selectLayoutSelector
		equals: nonDefaultSelector.
		
	mockSelector initializeWithExtensionsAllActivated.	
	self
		assert: mockSelector selectLayoutSelector
		equals: nonDefaultSelector
	
]

{ #category : #'tests - spec' }
StDebuggerLayoutSelectorTest >> testSelectSpecSelectorWithExtensions [
	| withExtensionSelector withoutExtensionSelector mockSelector |
	withExtensionSelector := self defaultSelectorWithExtensions.
	withoutExtensionSelector := self defaultSelectorWithoutExtensions.			
	mockSelector := StDebuggerUsingLayoutSelectorMock new.
	mockSelector layoutSelector: withExtensionSelector.	
			
	mockSelector initializeWithExtensionsNoneActivated.
	self
		assert: mockSelector selectLayoutSelector
		equals: withoutExtensionSelector.	
		
	mockSelector initializeWithoutExtensionsNoneActivated.
	self
		assert: mockSelector selectLayoutSelector
		equals: withoutExtensionSelector.
		
	mockSelector initializeWithoutExtensionsAllActivated.
	self
		assert: mockSelector selectLayoutSelector
		equals: withoutExtensionSelector.
		
	mockSelector initializeWithExtensionsAllActivated.
	self
		assert: mockSelector selectLayoutSelector
		equals: withExtensionSelector
]

{ #category : #'tests - spec' }
StDebuggerLayoutSelectorTest >> testSelectSpecSelectorWithoutExtensions [
	| withoutExtensionSelector mockSelector |
	withoutExtensionSelector := self defaultSelectorWithoutExtensions.			
	mockSelector := StDebuggerUsingLayoutSelectorMock new.
	mockSelector layoutSelector: withoutExtensionSelector.	
		
	mockSelector initializeWithExtensionsNoneActivated.		
	self
		assert: mockSelector selectLayoutSelector
		equals: withoutExtensionSelector.
		
	mockSelector initializeWithoutExtensionsNoneActivated.	
	self
		assert: mockSelector selectLayoutSelector
		equals: withoutExtensionSelector.
		
	mockSelector initializeWithoutExtensionsAllActivated.	
	self
		assert: mockSelector selectLayoutSelector
		equals: withoutExtensionSelector.
		
	mockSelector initializeWithExtensionsAllActivated.	
	self
		assert: mockSelector selectLayoutSelector
		equals: withoutExtensionSelector.
]

{ #category : #'tests - spec' }
StDebuggerLayoutSelectorTest >> testSelectorForDebuggerStatusExtensionsStatus [
	| selector |
	selector := specSelector
		selectorForDebuggerStatus: false
		extensionsStatus: false.
	self
		assert: selector
		equals: specSelector class defaultDebuggerWithoutExtensionLayoutSelector.
		
	selector := specSelector
		selectorForDebuggerStatus: true
		extensionsStatus: false.
	self
		assert: selector
		equals: specSelector class defaultDebuggerWithoutExtensionLayoutSelector.
		
	selector := specSelector
		selectorForDebuggerStatus: false
		extensionsStatus: true.
	self
		assert: selector
		equals: specSelector class defaultDebuggerWithoutExtensionLayoutSelector.
		
	selector := specSelector
		selectorForDebuggerStatus: true
		extensionsStatus: true.
	self
		assert: selector
		equals: specSelector class defaultDebuggerWithExtensionLayoutSelector
]
