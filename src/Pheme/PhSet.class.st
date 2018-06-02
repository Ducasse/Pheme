Class {
	#name : #PhSet,
	#superclass : #PhemooPrimitives,
	#category : #'Pheme-Phemoo'
}

{ #category : #accessing }
PhSet class >> tag [

	^ #set
]

{ #category : #evaluation }
PhSet >> valueFor: aCollection with: anInterpreter environment: anEnvironment [ 
	"Define does not evaluate the symbol but its argument"
	
	anEnvironment updateBinding: aCollection first value: (anInterpreter eval: aCollection second in: anEnvironment ).
	^ #undefined
]
