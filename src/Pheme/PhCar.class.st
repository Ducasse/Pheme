Class {
	#name : #PhCar,
	#superclass : #PhemooPrimitives,
	#category : #'Pheme-Phemoo'
}

{ #category : #accessing }
PhCar class >> tag [ 
	^ #car
]

{ #category : #evaluation }
PhCar >> valueFor: aCollection with: anInterpreter environment: anEnvironment [ 
	^ (anInterpreter eval: aCollection first in: anEnvironment) first
]
