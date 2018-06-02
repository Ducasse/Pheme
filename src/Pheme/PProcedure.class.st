Class {
	#name : #PProcedure,
	#superclass : #Object,
	#instVars : [
		'parameters',
		'body',
		'environment'
	],
	#category : #'Pheme-Infrastructure'
}

{ #category : #accessing }
PProcedure >> body [
	^ body
]

{ #category : #accessing }
PProcedure >> body: aCollection [ 
	body := aCollection
]

{ #category : #accessing }
PProcedure >> environment [ 	
	^ environment
]

{ #category : #accessing }
PProcedure >> environment: anEnvironment [
	environment := anEnvironment
]

{ #category : #execution }
PProcedure >> executeWithArguments: args using: anInterpreter [

	self setEnvironmentForParameters: args in: anInterpreter environment.
	"the design of not having a parameter for the eval: is bad because now I would need to 
	go and set the environment from the procedure to execute its body."
	anInterpreter eval: self body.
]

{ #category : #accessing }
PProcedure >> parameters [
	^ parameters
]

{ #category : #accessing }
PProcedure >> parameters: aCollection [ 
	parameters := aCollection
]

{ #category : #printing }
PProcedure >> printOn: aStream [

	super printOn: aStream. 
	aStream space.
	aStream nextPutAll: self parameters asString.
	aStream space; cr ; tab.
	aStream nextPutAll: '[ ', self body asString, ' ]'
]

{ #category : #operate }
PProcedure >> setEnvironmentForParameters: values in: outerEnvironment [
	"Create a new environment inheriting from the procedure one, for the current application."
	| applicationEnvironment |
	applicationEnvironment := PEnvironment newFromKeys: self parameters andValues: values.
	applicationEnvironment outerEnvironment: outerEnvironment.
	^ applicationEnvironment
]
