Class {
	#name : #PhSmaller,
	#superclass : #PhemooPrimitives,
	#category : #'Pheme-Phemoo'
}

{ #category : #accessing }
PhSmaller class >> tag [

	^ #<
]

{ #category : #evaluation }
PhSmaller >> valueFor: aCollection with: anInterpreter environment: anEnvironment [ 
	
	^ (anInterpreter eval: aCollection first in: anEnvironment ) < (anInterpreter eval: aCollection second in: anEnvironment ) 
	
]
