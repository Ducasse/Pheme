Extension { #name : #DictionaryTest }

{ #category : #'*pheme' }
DictionaryTest >> testAtMaxDo [
	| res |
	res := 0.
	{(#a -> -1).
	(#b -> -1).
	(#c -> -1).
	(#d -> -1)} asDictionary atMax: 2 keysAndValuesDo: [ :each | res := res + each value ].
	self assert: res equals: -2
]

{ #category : #'*pheme' }
DictionaryTest >> testAtMaxDoNotEnough [
	| res |
	res := 0.
	{(#a -> -1).
	(#b -> -1).
	(#c -> -1).
	(#d -> -1)} asDictionary atMax: 6 keysAndValuesDo: [ :each | res := res + each value ].
	self assert: res equals: -4
]
