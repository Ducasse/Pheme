Class {
	#name : #PhEqual,
	#superclass : #PhemooPrimitives,
	#category : #'Pheme-Phemoo'
}

{ #category : #accessing }
PhEqual class >> tag [ 
	^ #=
]

{ #category : #evaluation }
PhEqual >> valueFor: aCollection with: anInterpreter environment: anEnvironment [ 
	^ (anInterpreter eval: aCollection first in: anEnvironment ) = (anInterpreter eval: aCollection second in: anEnvironment )
]
