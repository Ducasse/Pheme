Class {
	#name : #PhIf,
	#superclass : #PhemooPrimitives,
	#category : #'Pheme-Phemoo'
}

{ #category : #accessing }
PhIf class >> tag [

	^ #if
]

{ #category : #evaluation }
PhIf >> valueFor: aCollection with: anInterpreter environment: anEnvironment [ 
	"aCollection: (if cond expr1 expr2)"

	| cond |
	cond := anInterpreter eval: aCollection first in: anEnvironment.
	^ cond
		ifTrue: [ anInterpreter eval: aCollection second in: anEnvironment ]
		ifFalse: [ anInterpreter eval: aCollection third in: anEnvironment ]
]
