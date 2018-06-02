Class {
	#name : #PhMult,
	#superclass : #PhemooPrimitives,
	#category : #'Pheme-Phemoo'
}

{ #category : #accessing }
PhMult class >> tag [
	^ #*
]

{ #category : #evaluation }
PhMult >> valueFor: aCollection with: anInterpreter environment: anEnvironment [ 
	^ aCollection fold: [ :a :b | (anInterpreter eval: a in: anEnvironment ) *  (anInterpreter eval: b in: anEnvironment ) ]
]
