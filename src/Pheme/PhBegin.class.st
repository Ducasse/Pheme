Class {
	#name : #PhBegin,
	#superclass : #PhemooPrimitives,
	#category : #'Pheme-Phemoo'
}

{ #category : #accessing }
PhBegin class >> tag [ 

	^ #begin
]

{ #category : #evaluation }
PhBegin >> valueFor: aCollection with: anInterpreter environment: anEnvironment [ 
	"aCollection: (expr1 expr2 ... exprn)"

	| res | 
	(aCollection do: [:each | res := anInterpreter eval: each in: anEnvironment]).
	^ res 	
]
