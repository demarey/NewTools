Extension { #name : 'PickOneSetting' }

{ #category : '*NewTools-SettingsBrowser' }
PickOneSetting >> asSettingPresenterWithOwner: aPresenter [
	"Answer an appropriate <SpPresenter> container for the receiver's value"
self haltIf: [ label = 'Window position strategy' ].

	^ aPresenter instantiate: StSettingDropListPresenterItem on: self
]
