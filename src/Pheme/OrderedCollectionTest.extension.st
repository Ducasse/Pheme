Extension { #name : #OrderedCollectionTest }

{ #category : #'*Pheme' }
OrderedCollectionTest >> testAtMaxDo [
	| res |
	res := 0.
	#(-1 -2 -3 -4) atMax: 2 do: [ :each | res := res + each ].
	self assert: res equals: -3.
]

{ #category : #'*Pheme' }
OrderedCollectionTest >> testAtMaxDoNotEnoughItems [
	| res |
	res := 0.
	#(-1 -2 -3 -4) atMax: 6 do: [ :each | res := res + each ].
	self assert: res equals: -10
]
