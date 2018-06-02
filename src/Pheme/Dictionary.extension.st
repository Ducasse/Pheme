Extension { #name : #Dictionary }

{ #category : #'*Pheme' }
Dictionary >> atMax: numberOfItems keysAndValuesDo: aBlock [
	"Execute the iteration with at the maximum numberOfItems. If the receiver contains less than numberOfItems iterate them all."
	| already |
	tally = 0 ifTrue: [^ self].
	already := 0.
	self associationsDo: [ :ass | 
		already < numberOfItems
			ifTrue: [ aBlock value: ass.
						already := already + 1 ]
			ifFalse: [ ^ self ]]
			 
		
]

{ #category : #'*pheme' }
Dictionary class >> newFromKeys: keys andValues: values [
	"Create a dictionary from the keys and values arguments which should have the same length."
	
	"(Dictionary newFromKeys: #(#x #y) andValues: #(3 6)) >>> (Dictionary new at: #x put: 3; at: #y put: 6 ;yourself)"
	
	| dict |
	dict := self new.
	keys with: values do: [ :k :v | dict at: k put: v ].
	^ dict
]
