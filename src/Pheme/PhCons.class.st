Class {
	#name : #PhCons,
	#superclass : #PhemooPrimitives,
	#category : #'Pheme-Phemoo'
}

{ #category : #accessing }
PhCons class >> tag [
	^ #cons
]

{ #category : #evaluation }
PhCons >> valueFor: aCollection with: anInterpreter environment: anEnvironment [ 
	" #(#(#quote #a) #())	"
	^ ((anInterpreter eval: aCollection second in: anEnvironment) asOrderedCollection) 
			addFirst: (anInterpreter eval: aCollection first in: anEnvironment ); yourself ; asArray
]
