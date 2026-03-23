Class {
	#name : 'StNewSettingNode',
	#superclass : 'Object',
	#instVars : [
		'setting',
		'tree'
	],
	#category : 'NewTools-SettingsBrowser-Model',
	#package : 'NewTools-SettingsBrowser',
	#tag : 'Model'
}

{ #category : 'instance creation' }
StNewSettingNode class >> forSetting: aSetting [

	^ self new
		setting: aSetting;
		yourself
]

{ #category : 'accessing' }
StNewSettingNode >> allChildren [

	"Answer a <Collection> of the settings for which the receiver is set as parent"

	^ tree
		ifNotNil: [ :settingTree | settingTree childrenOf: self ]
		ifNil: [ OrderedCollection new ]
]

{ #category : 'converting' }
StNewSettingNode >> asPresenterOn: aPresenter [ 

	^ setting asSettingPresenterWithOwner: aPresenter 
]

{ #category : 'testing' }
StNewSettingNode >> hasChildren [
	
	^ setting isGroup and: [ self allChildren isNotEmpty]
]

{ #category : 'testing' }
StNewSettingNode >> hasGroup [ 

	^ setting hasGroup
]

{ #category : 'testing' }
StNewSettingNode >> hasParent [
	
	^ setting hasGroup
]

{ #category : 'accessing' }
StNewSettingNode >> label [
	
	^ setting label
]

{ #category : 'accessing' }
StNewSettingNode >> level [
	
	^ self path size
]

{ #category : 'accessing' }
StNewSettingNode >> name [
	
	^ setting name
]

{ #category : 'accessing' }
StNewSettingNode >> nodeForGroup: aSettingGroup [

	^ tree nodeForSetting: aSettingGroup
]

{ #category : 'accessing' }
StNewSettingNode >> order [
	^ setting order
]

{ #category : 'accessing' }
StNewSettingNode >> order: anInteger [ 

	self flag: 'should be setting order or node order?'.
	
	setting order: anInteger.
]

{ #category : 'accessing' }
StNewSettingNode >> parentName [
	
	^ setting group ifNotNil: [ :group | group name ]
]

{ #category : 'accessing' }
StNewSettingNode >> parentNode [
	
	^ self nodeForGroup: setting group
]

{ #category : 'accessing' }
StNewSettingNode >> path [

	^ self hasParent
		ifTrue: [ self parentNode path, { self } ]
		ifFalse: [ { self } ]
]

{ #category : 'accessing' }
StNewSettingNode >> setting [
	^ setting
]

{ #category : 'accessing' }
StNewSettingNode >> setting: aSetting [

	setting := aSetting
]

{ #category : 'accessing' }
StNewSettingNode >> settingDeclaration [
	
	^ setting
]

{ #category : 'accessing' }
StNewSettingNode >> tree: aSettingTree [

	tree := aSettingTree 
]
