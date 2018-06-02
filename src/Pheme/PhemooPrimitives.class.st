Class {
	#name : #PhemooPrimitives,
	#superclass : #Object,
	#category : #'Pheme-Phemoo'
}

{ #category : #accessing }
PhemooPrimitives class >> tag [

	^ self subclassResponsibility 
]

{ #category : #evaluation }
PhemooPrimitives >> valueFor: aCollection with: anInterpreter environment: anEnvironment [ 
	^ self subclassResponsibility
]
