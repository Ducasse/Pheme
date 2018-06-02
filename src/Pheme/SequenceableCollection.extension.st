Extension { #name : #SequenceableCollection }

{ #category : #'*Pheme' }
SequenceableCollection >> atMax: numberOfItems do: aBlock [
	"Execute the iteration with at the maximum numberOfItems. If the receiver contains less than numberOfItems iterate them all."
	1 to: (numberOfItems min: self size) do: [:index | aBlock value: (self at: index)]
]
