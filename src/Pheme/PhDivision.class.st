Class {
	#name : #PhDivision,
	#superclass : #PhemooPrimitives,
	#category : #'Pheme-Phemoo'
}

{ #category : #accessing }
PhDivision class >> tag [ 
	^ #/
]

{ #category : #evaluation }
PhDivision >> valueFor: aCollection with: anInterpreter environment: anEnvironment [ 
	^ (anInterpreter eval: aCollection first in: anEnvironment ) /  (anInterpreter eval: aCollection second in: anEnvironment)
]
