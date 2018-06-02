Class {
	#name : #PhCdr,
	#superclass : #PhemooPrimitives,
	#category : #'Pheme-Phemoo'
}

{ #category : #accessing }
PhCdr class >> tag [
	^ #cdr
]

{ #category : #evaluation }
PhCdr >> valueFor: aCollection with: anInterpreter environment: anEnvironment [ 
	"aCollection is the cdr of the list i.e. one array with one element"
	"we should evaluate the argument and return a list"

	^ (anInterpreter eval: aCollection first in: anEnvironment) allButFirst
]
