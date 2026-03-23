Extension { #name : 'Setting' }

{ #category : '*NewTools-SettingsBrowser' }
Setting >> asSettingPresenterWithOwner: aPresenter [
	"Answer an appropriate <SpPresenter> container for the receiver's value"

	^ self
		  ifPreconditionTrue: [ self realValue asSettingPresenter: self owner: aPresenter ]
		  ifFalse: [ SpNullPresenter owner: aPresenter ]
]
