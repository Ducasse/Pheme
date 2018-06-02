Class {
	#name : #PhQuote,
	#superclass : #PhemooPrimitives,
	#category : #'Pheme-Phemoo'
}

{ #category : #accessing }
PhQuote class >> tag [

	^ #quote
]

{ #category : #evaluation }
PhQuote >> valueFor: aCollection with: anInterpreter environment: anEnvironment [ 
	"quote does not evaluate its receiver! This is the whole point."
	"with (quote 'a) eval will invoke valueFor:in: with #('a)"

	^ aCollection first
]
