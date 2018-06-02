Class {
	#name : #PhemooTest,
	#superclass : #CommonPhemeTest,
	#category : #'Pheme-Tests'
}

{ #category : #'set up' }
PhemooTest >> setUp [
	super setUp.
	ph := Phemoo new
]
