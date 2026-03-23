Extension { #name : 'PhLSettingsGroup' }

{ #category : '*NewTools-SettingsBrowser' }
PhLSettingsGroup >> asSettingPresenterWithOwner: aPresenter [
	"Answer an appropriate <SpPresenter> container for the receiver's value"

	^ aPresenter newLabel 
		addStyle: 'settingLabel';
		label: self label;
		yourself
]
