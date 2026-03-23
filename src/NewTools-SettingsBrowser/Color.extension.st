Extension { #name : 'Color' }

{ #category : '*NewTools-SettingsBrowser' }
Color >> asSettingPresenter: aSettingDeclaration owner: aPresenter [
	| settingPresenter colorValue |
	
	colorValue := aSettingDeclaration realValue.
	settingPresenter := (aPresenter instantiate: StSettingSHStyleButtonColorPresenterItem on: aSettingDeclaration).
	settingPresenter
		buttonAction: [ aSettingDeclaration getColorFor: settingPresenter ];
		buttonColor: colorValue;
		yourself.
		
	^ settingPresenter
]
