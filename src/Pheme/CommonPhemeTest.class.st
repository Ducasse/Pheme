Class {
	#name : #CommonPhemeTest,
	#superclass : #TestCase,
	#instVars : [
		'ph'
	],
	#category : #'Pheme-Tests'
}

{ #category : #testing }
CommonPhemeTest class >> isAbstract [
	^ self = CommonPhemeTest
]

{ #category : #'setup - teardown' }
CommonPhemeTest >> setUp [

	ph := Phsyche new
	
]

{ #category : #'tests variable definition evaluation' }
CommonPhemeTest >> testDefineExpression [
	ph parseAndEval: '(define pi 3.14)'.
	self 
		assert: (ph  parseAndEval: 'pi')
		equals:  3.14.
]

{ #category : #'tests primitives' }
CommonPhemeTest >> testDivision [
	self should: [ ph parseAndEval: '(/ 5 0)'] raise: ZeroDivide 
]

{ #category : #'tests special forms' }
CommonPhemeTest >> testEvalBegin [
	self assert: (ph parseAndEval: '(begin 1 2 3)') equals: 3

]

{ #category : #'tests special forms' }
CommonPhemeTest >> testEvalBeginSet [
	self assert: (ph parseAndEval:  '(begin (define x 1) (set x 2) x)') equals: 2

]

{ #category : #'tests elementary elements evaluation' }
CommonPhemeTest >> testEvalBoolean [
	self assert: (ph parseAndEval: 'true') equals: true.
	self assert: (ph parseAndEval: 'false') equals: false.
]

{ #category : #'tests low level list' }
CommonPhemeTest >> testEvalCarExpressionEvaluatesItsArgument [
	self
		assert: (ph parseAndEval:  '(car (cons (quote a) (cons (quote b) ())))')
		equals: #a
]

{ #category : #'tests list primitives' }
CommonPhemeTest >> testEvalCdrExpressionEvaluatesItsArgument [
	self assert: (ph parseAndEval: '(cdr (quote (quote a)))') equals: #(a)
]

{ #category : #'tests low level list' }
CommonPhemeTest >> testEvalCons [
	self assert: (ph parseAndEval: '(cons (quote a) (cons (quote b) ()))') equals: #(a b)
]

{ #category : #'tests procedures' }
CommonPhemeTest >> testEvalDefineWithPrimitives [
	ph parseAndEval: '(define rr (* 3 8))'.
	self assert: (ph eval: #rr) equals: 24
]

{ #category : #'tests elementary elements evaluation' }
CommonPhemeTest >> testEvalEmptyList [
	self assert: (ph parseAndEval: '()') equals: #()
]

{ #category : #'tests primitives' }
CommonPhemeTest >> testEvalExpression [

	self assert: (ph parseAndEval: '(* 3 8)') equals: 24
]

{ #category : #'tests variable definition evaluation' }
CommonPhemeTest >> testEvalExpression2 [
	ph parseAndEval: '(define pi 3.14)'.
	ph parseAndEval: '(define pi2 pi)'.
	ph parseAndEval: '(define pi 6.28)'.
	self assert: (ph parseAndEval: 'pi2') equals: 3.14
]

{ #category : #'tests special forms' }
CommonPhemeTest >> testEvalIf [
	self assert: (ph parseAndEval: '(if true 4 5)') equals: 4.
	self assert: (ph parseAndEval: '(if false 4 5)') equals: 5
]

{ #category : #'tests special forms' }
CommonPhemeTest >> testEvalIfNoSpurious [
	self assert: (ph parseAndEval: '(if true 4 (/ 5 0))') equals: 4.
	self assert: (ph parseAndEval: '(if false (/ 5 0) 5)') equals: 5
]

{ #category : #'tests special forms' }
CommonPhemeTest >> testEvalIfRequiringPrimitives [
	self assert: (ph parseAndEval: '(if (< 2 3) 4 5)') equals: 4.
	self assert: (ph parseAndEval: '(if (< 3 2) 4 5)') equals: 5
]

{ #category : #'tests list primitives' }
CommonPhemeTest >> testEvalListExpression [
	self assert: (ph parseAndEval: '(cons (quote a) ())') equals: #(a)
]

{ #category : #'tests primitives' }
CommonPhemeTest >> testEvalMoreComplexExpression [
	self assert: (ph parseAndEval: '(* (+ 2 3) 8)') equals: 40.
	self assert: (ph parseAndEval: '(* 8 (+ 2 3))') equals: 40
]

{ #category : #'tests primitives' }
CommonPhemeTest >> testEvalMultiplication [
	self assert: (ph parseAndEval: '(* 3 8)') equals: 24
]

{ #category : #'tests elementary elements evaluation' }
CommonPhemeTest >> testEvalNumber [
	self assert: (ph parseAndEval: '12') equals: 12.
	self assert: (ph parseAndEval: '3.14') equals: 3.14.
]

{ #category : #'tests special forms' }
CommonPhemeTest >> testEvalQuote [
	self assert: (ph parseAndEval: '(quote (* x x))') equals: #(#* #x #x).
	self assert: (ph parseAndEval: '(quote (quote (* x x)))') equals: #(quote #(#* #x #x))
	
]

{ #category : #'tests special forms' }
CommonPhemeTest >> testEvalSetAtCorrectLevel [
	| proc |
	ph parseAndEval: '
	(define fy3 
  		((lambda (x)
   			(lambda (y)
				(begin
      				(set x (+ x 2))
					(+ x y))))
  			3))
'.
	proc := ph eval: #fy3.
	self assert: (ph parseAndEval: '(fy3 5)') equals: 10.
	self assert: (ph parseAndEval: '(fy3 5)') equals: 12.
]

{ #category : #'tests special forms' }
CommonPhemeTest >> testEvalSimpleSet [
	self assert: (ph parseAndEval: '(define x2 21') equals: #undefined.
	self assert: (ph parseAndEval: '(set x2 22)') equals: #undefined.
	self assert: (ph parseAndEval: 'x2') equals: 22.
]

{ #category : #'tests primitives' }
CommonPhemeTest >> testEvalSum [
	self assert: (ph parseAndEval: '(+ 3 8)') equals: 11
]

{ #category : #'test procedure closures' }
CommonPhemeTest >> testFactorial [
	ph parseAndEval: '(define factorial (lambda (n) (if (= n 1) 1 (* n (factorial (- n 1) )))))'.
	self assert: (ph parseAndEval: '(factorial 3)') equals: 6
]

{ #category : #'tests list primitives' }
CommonPhemeTest >> testIsNull [
	self assert: (ph parseAndEval: '(isNull #())').
	self assert: (ph parseAndEval: '(isNull (quote ()))').
	self deny: (ph parseAndEval: '(isNull (cons (quote a) #()))')
]

{ #category : #'tests special forms' }
CommonPhemeTest >> testLambdaProcedureExecution [
	self assert: (ph parseAndEval: '((lambda (x) (* x x)) 3)') equals: 9.
	
]

{ #category : #'tests boolean primitives' }
CommonPhemeTest >> testNot [
	self assert: (ph parseAndEval: '(not false)').
	self deny: (ph parseAndEval: '(not true)').
]

{ #category : #'tests procedures' }
CommonPhemeTest >> testOtherReference [
	ph parseAndEval: '(define pi 3.14)'.
	ph parseAndEval: '(define twoPi (* pi 2)'.
	self assert: (ph parseAndEval: #twoPi) equals: 3.14 * 2
]

{ #category : #'test parsing' }
CommonPhemeTest >> testParse [

	self 
		assert: (ph parse: '(begin (define r 10) (* pi (* r r)))')
		equals:   #(#begin #(#define #r 10) #(#* #pi #(#* #r #r)))
]

{ #category : #'tests parsing' }
CommonPhemeTest >> testParseEmptyList [
	self assert: (ph parse: '()') equals: #().
	self assert: (ph parse: '#()') equals: #()
]

{ #category : #'tests parsing' }
CommonPhemeTest >> testParseExpression [

	self 
		assert: (ph parse: '(define r 10)')
		equals: #(#define #r 10)
]

{ #category : #'tests parsing' }
CommonPhemeTest >> testParseFloat [
	self 
		assert: (ph parse: '12.33')
		equals: 12.33
]

{ #category : #'tests parsing' }
CommonPhemeTest >> testParseIsNull [
	self assert: (ph parse: '(isNull (cons (quote a) #()))') equals: #(#isNull #(#cons #(#quote #a) #())).
	self assert: (ph parse: '(isNull (cons (quote a) ()))') equals: #(#isNull #(#cons #(#quote #a) #()))
]

{ #category : #'tests parsing' }
CommonPhemeTest >> testParseLambda [
	self 
		assert: (ph parse: '(define squared (lambda (x) (* x x)))') 
		equals: #(#define #squared #(#lambda #(#x) #(* x x)))
]

{ #category : #'tests parsing' }
CommonPhemeTest >> testParseNumber [

	self 
		assert: (ph parse: '12')
		equals: 12
]

{ #category : #'tests parsing' }
CommonPhemeTest >> testParseSymbol [

	self 
		assert: (ph parse: 'r')
		equals: #r
]

{ #category : #'tests procedures' }
CommonPhemeTest >> testProcedure [
	ph parseAndEval: '(define squared (lambda (x) (* x x)))'.
	self assert: (ph parseAndEval: '(squared 3)') equals: 9
]

{ #category : #'tests procedures' }
CommonPhemeTest >> testProcedureDefinition [
	| proc |
	ph parseAndEval: '(define squared (lambda (x) (* x x)))'.
	proc := ph parseAndEval: #squared.
	self assert: proc parameters equals: #(#x).
	self assert: proc body equals: #(#* #x #x)
]

{ #category : #'tests procedures' }
CommonPhemeTest >> testProcedureExecution [
	ph parseAndEval: '(define squared (lambda (x) (* x x)))'.
	self assert: (ph parseAndEval: '(squared 3)') equals: 9
]

{ #category : #'test procedure closures' }
CommonPhemeTest >> testSimpleClosure [
	| res |
	res := (ph parseAndEval: 
					'
(
  ((lambda (x)
     (lambda (y)
       (+ x y)))
   3)
 7)
').
	self assert: res equals: 10
]

{ #category : #'test procedure closures' }
CommonPhemeTest >> testSimpleClosureIntrospection [
	| proc |
	(ph parseAndEval: 
					'(define fy3 
  ((lambda (x)
   (lambda (y)
      x))
  3))').
	proc := ph parseAndEval: '#fy3'.
	self assert: proc parameters equals: #(y).
	self assert: (proc environment at: #x) equals: 3
]

{ #category : #'tests procedures' }
CommonPhemeTest >> testSimpleProcedureExecution [
	(ph parseAndEval: '(define pi 3.14)').
	(ph parseAndEval:  '(define Pimult (lambda (x) (* pi x))))').
	self assert: (ph parseAndEval: '(Pimult 2)') equals: 3.14 * 2
]
