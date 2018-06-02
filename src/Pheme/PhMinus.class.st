Class {
	#name : #PhMinus,
	#superclass : #PhemooPrimitives,
	#category : #'Pheme-Phemoo'
}

{ #category : #accessing }
PhMinus class >> tag [ 
	
	^ #-
]

{ #category : #evaluation }
PhMinus >> valueFor: aCollection with: anInterpreter environment: anEnvironment [ 
	^ (anInterpreter eval: aCollection first in: anEnvironment ) - (anInterpreter eval: aCollection second in: anEnvironment )
]
