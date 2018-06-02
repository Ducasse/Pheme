Class {
	#name : #PhDefine,
	#superclass : #PhemooPrimitives,
	#category : #'Pheme-Phemoo'
}

{ #category : #accessing }
PhDefine class >> tag [
	^ #define
]

{ #category : #evaluation }
PhDefine >> valueFor: aCollection with: anInterpreter environment: anEnvironment [ 
	"Define does not evaluate the symbol but its argument"
	anEnvironment defineBinding: aCollection first value: (anInterpreter eval: aCollection second in: anEnvironment).
	^ #undefined
]
