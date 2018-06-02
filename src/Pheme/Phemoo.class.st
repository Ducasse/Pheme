"
Phemo is a limited subset of Scheme interpreter. It is fully described in the associated booklet: A Mini Scheme in Pharo available at http://books.pharo.org

It uses a different way to manage primitives. There are represented as object instances. 


"
Class {
	#name : #Phemoo,
	#superclass : #Object,
	#instVars : [
		'primitives',
		'environment'
	],
	#category : #'Pheme-Phemoo'
}

{ #category : #environment }
Phemoo >> at: aSymbol [
	^ environment at: aSymbol
]

{ #category : #environment }
Phemoo >> defineBinding: aSymbol value: aValue [
	environment at: aSymbol put: aValue
]

{ #category : #accessing }
Phemoo >> environment [
	^ environment
]

{ #category : #evaluation }
Phemoo >> eval: expression [

	^ self eval: expression in: environment
]

{ #category : #evaluation }
Phemoo >> eval: expression in: anEnvironment [
	expression = #()
		ifTrue: [ ^ expression ].
	expression isSymbol
		ifTrue: [ ^ anEnvironment at: expression ].
	expression isArray
		ifFalse: [ ^ expression ]
		ifTrue: [ (self isPrimitive: expression first)
				ifTrue: [ ^ self evaluateNonApplicativeOrder: expression in: anEnvironment]
				ifFalse: [ "Now we have function application ((lambda (x) (+ x 3)) (+ 9 1))" 
						^ self evaluateApplicativeOrder: expression in: anEnvironment] ]
]

{ #category : #evaluation }
Phemoo >> evaluateApplicativeOrder: expression in: anEnvironment [
	"Now we have function application ((lambda (x) (+ x 3)) (+ 9 1))"
	| proc applicationEnv |
	proc := self eval: expression first in: anEnvironment.
	applicationEnv := proc
		setEnvironmentForParameters: (expression allButFirst collect: [ :e | self eval: e in: anEnvironment])
		in: proc environment.
	
	^ self eval: proc body in: applicationEnv.


]

{ #category : #evaluation }
Phemoo >> evaluateNonApplicativeOrder: expression in: anEnvironment [
	^ (anEnvironment at: expression first)
		valueFor: expression allButFirst
		with: self
		environment: anEnvironment 
]

{ #category : #accessing }
Phemoo >> initialize [
	environment := PEnvironment new.
	primitives := OrderedCollection new.
	self initializePrimitives
]

{ #category : #accessing }
Phemoo >> initializePrimitives [
	
	^ PhemooPrimitives allSubclasses 	
			do: [ :cls | primitives add: cls tag. 
					environment at: cls tag put: cls new ]
]

{ #category : #accessing }
Phemoo >> isPrimitive: aTag [
	^ primitives includes: aTag
]

{ #category : #reading }
Phemoo >> parse: aProgramString [

	aProgramString ifEmpty: [ ^ #() ].
	^ (Scanner new scanTokens: aProgramString) first 
]

{ #category : #evaluation }
Phemoo >> parseAndEval: anExpression [

	^ self eval: (self parse: anExpression)
]

{ #category : #environment }
Phemoo >> updateBinding: aSymbol value: aValue [
	environment lookupAt: aSymbol put: aValue
]
