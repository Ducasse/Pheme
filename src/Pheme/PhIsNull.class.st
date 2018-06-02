Class {
	#name : #PhIsNull,
	#superclass : #PhemooPrimitives,
	#category : #'Pheme-Phemoo'
}

{ #category : #accessing }
PhIsNull class >> tag [ 
	^ #isNull
]

{ #category : #evaluation }
PhIsNull >> valueFor: aCollection with: anInterpreter environment: anEnvironment [ 
	"aCollection: #(#())"

	^  (anInterpreter eval: aCollection first in: anEnvironment) = #()
]
