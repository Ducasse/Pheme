"
Physche is a limited subset of Scheme interpreter. It is fully described in the associated booklet: A Mini Scheme in Pharo available at http://books.pharo.org


"
Class {
	#name : #Phsyche,
	#superclass : #Object,
	#instVars : [
		'environment',
		'primitives'
	],
	#category : #'Pheme-Interpreters'
}

{ #category : #'primitives - list' }
Phsyche >> carBinding [
	^ #car -> [ :l | l first ]
]

{ #category : #'primitives - list' }
Phsyche >> cdrBinding [
	^ #cdr -> [ :l | l allButFirst ]
]

{ #category : #'primitives - list' }
Phsyche >> consBinding [
	^ #cons -> [ :e :l | {e} , l ]
]

{ #category : #primitives }
Phsyche >> divisionBinding [
	^ #/ -> [ :e :v | (e / v) asFloat ]
]

{ #category : #'primitives - list' }
Phsyche >> equalBinding [
	^ #= -> [ :a :b | a = b ]
]

{ #category : #evaluation }
Phsyche >> eval: expression [
	^ self eval: expression in: environment
]

{ #category : #evaluation }
Phsyche >> eval: expression in: anEnvironment [
	expression = #()
		ifTrue: [ ^ expression ].
	expression isSymbol
		ifTrue: [ ^ anEnvironment at: expression ].	"returns the variable value"
	expression isArray
		ifFalse: [ "returns literals boolean, string, number" ^ expression ]
		ifTrue: [ | first |
			first := expression first.
			(primitives includes: first)
				ifTrue: [ ^ self evalPrimitive: expression in: anEnvironment ]
				ifFalse: [ first = #define
						ifTrue: [ ^ self evalDefineSpecialForm: expression in: anEnvironment ].
					first = #set
						ifTrue: [ ^ self evalSetSpecialForm: expression in: anEnvironment ].
					first = #lambda
						ifTrue: [ ^ self evalLambdaSpecialForm: expression in: anEnvironment ].
					first = #begin
						ifTrue: [ ^ self evalBeginSpecialForm: expression in: anEnvironment ].
					first = #if
						ifTrue: [ ^ self evalIfSpecialForm: expression in: anEnvironment].
					first = #quote
						ifTrue: [ ^ expression second ]
						ifFalse: [ "Now we have function application ((lambda (x) (+ x 3)) (+ 9 1))" 
							^ self evalApplicativeOrder: expression in: anEnvironment ] ] ]
]

{ #category : #evaluation }
Phsyche >> evalApplicativeOrder: expression in: anEnvironment [
	| proc newEnv |
	"Now we have function application ((lambda (x) (+ x 3)) (+ 9 1))"
	proc := self eval: expression first in: anEnvironment.
	newEnv := proc
		setEnvironmentForParameters: (expression allButFirst collect: [ :e | self eval: e in: anEnvironment ])
		in: proc environment.
	^ self eval: proc body in: newEnv
]

{ #category : #evaluation }
Phsyche >> evalBeginSpecialForm: expression in: anEnvironment [
	| res |
	expression allButFirst do: [ :each | res := self eval: each in: anEnvironment ].
	^ res
]

{ #category : #evaluation }
Phsyche >> evalDefineSpecialForm: expression in: anEnvironment [
	anEnvironment at: expression second put: (self eval: expression third in: anEnvironment).
	^ #undefined
]

{ #category : #evaluation }
Phsyche >> evalIfSpecialForm: expression in: anEnvironment [
	^ (self eval: expression second in: anEnvironment)
		ifTrue: [ self eval: expression third in: anEnvironment ]
		ifFalse: [ self eval: expression fourth in: anEnvironment ]
]

{ #category : #evaluation }
Phsyche >> evalLambdaSpecialForm: expression in: anEnvironment [
	^ PProcedure new
		parameters: expression second;
		body: expression third;
		environment: anEnvironment
]

{ #category : #evaluation }
Phsyche >> evalPrimitive: expression in: anEnvironment [
	^ (anEnvironment at: expression first) valueWithPossibleArgs: (expression allButFirst collect: [ :e | self eval: e in: anEnvironment])
]

{ #category : #evaluation }
Phsyche >> evalSetSpecialForm: expression in: anEnvironment [
	anEnvironment lookupAt: expression second put: (self eval: expression third in: anEnvironment).
	^ #undefined
]

{ #category : #initialization }
Phsyche >> initialize [

	super initialize.
	environment := PEnvironment new. 
	primitives := OrderedCollection new. 
	self initializeEnvBindings 
]

{ #category : #initialization }
Phsyche >> initializeEnvBindings [
	(self class selectors select: [ :each | each endsWith: 'Binding' ])
		do: [ :s | 
				| b |
				b := self perform: s. 
				primitives add: b key. 
				environment at: b key put: b value ]
]

{ #category : #'primitives booleans' }
Phsyche >> isNotBinding [
	^ #not -> [ :a | a not ]
]

{ #category : #'primitives - list' }
Phsyche >> isNullBinding [
	^ #isNull -> [ :l | l = #() ]
]

{ #category : #primitives }
Phsyche >> isSymbolBinding [
	^ #isSymbol -> [ :e | e isSymbol ]
]

{ #category : #primitives }
Phsyche >> minusBinding [
	^ #- -> [ :e :v | e - v ]
]

{ #category : #primitives }
Phsyche >> multBinding [

	^ #* -> [:e :v | e * v]
]

{ #category : #parsing }
Phsyche >> parse: aProgramString [
	aProgramString ifEmpty: [ ^ #() ].
	^ (Scanner new scanTokens: aProgramString) first 
]

{ #category : #evaluation }
Phsyche >> parseAndEval: anExpression [

	^ self eval: (self parse: anExpression)
]

{ #category : #primitives }
Phsyche >> plusBinding [

	^ #+ -> [:e :v | e + v]
]

{ #category : #primitives }
Phsyche >> smallerBinding [

	^ #< -> [:e :v | e < v]
]
