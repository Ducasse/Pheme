Class {
	#name : #PhLambda,
	#superclass : #PhemooPrimitives,
	#category : #'Pheme-Phemoo'
}

{ #category : #accessing }
PhLambda class >> tag [

	^ #lambda
]

{ #category : #evaluation }
PhLambda >> valueFor: aCollection with: anInterpreter environment: anEnvironment [ 
	"aCollection: (arg body)"

	^ PProcedure new
			parameters: aCollection first;
			body: aCollection second;
			environment: anEnvironment
]
