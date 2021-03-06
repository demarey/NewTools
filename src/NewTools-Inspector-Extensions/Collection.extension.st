Extension { #name : #Collection }

{ #category : #'*NewTools-Inspector-Extensions' }
Collection >> inspectionItems [
	<inspectorPresentationOrder: 0 title: 'Items'> 
	
	^ SpTablePresenter new
		addColumn: (SpIndexTableColumn new 
			title: 'Index';
			sortFunction: #yourself ascending;
			beNotExpandable;
			yourself);
		addColumn: (SpStringTableColumn new  
			title: 'Value'; 
			evaluated: [ :each | StObjectPrinter asTruncatedTextFrom: each ];
			sortFunction: #printString ascending;
			yourself);
		items: self asOrderedCollection;
		yourself
]
