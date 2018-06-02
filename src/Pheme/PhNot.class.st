Class {
	#name : #PhNot,
	#superclass : #PhemooPrimitives,
	#category : #'Pheme-Phemoo'
}

{ #category : #accessing }
PhNot class >> tag [ 

	^ #not
]

{ #category : #evaluation }
PhNot >> valueFor: aCollection with: anInterpreter environment: anEnvironment [ 
	^ (anInterpreter eval: aCollection first in: anEnvironment) not
]
