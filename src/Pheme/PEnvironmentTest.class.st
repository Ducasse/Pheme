Class {
	#name : #PEnvironmentTest,
	#superclass : #TestCase,
	#instVars : [
		'outer',
		'inner'
	],
	#category : #'Pheme-Infrastructure'
}

{ #category : #setup }
PEnvironmentTest >> setUp [
	outer := PEnvironment new.
	inner := PEnvironment new.
	inner outerEnvironment: outer
]

{ #category : #tests }
PEnvironmentTest >> testAtPutIsModifyingInnerMost [
	outer at: #dad put: 'donald'.
	inner at: #son put: 'riri'.
	self assert: (inner at: #son) equals: 'riri'.
	inner at: #son put: 'fifi'.
	self assert: (inner at: #son) equals: 'fifi'.
	self deny: (outer keys includes: #son)
]

{ #category : #tests }
PEnvironmentTest >> testLookingOuterFromInner [
	outer at: #dad put: 'donald'.
	inner at: #son put: 'riri'.
	self assert: (inner at: #dad) equals: 'donald'
]

{ #category : #tests }
PEnvironmentTest >> testLookupAtRightLevel [
	outer at: #dad put: 'donald'.
	self assert: (outer at: #dad) equals: 'donald'.
	inner at: #son put: 'riri'.
	self assert: (inner at: #son) equals: 'riri'
]

{ #category : #tests }
PEnvironmentTest >> testLookupInFails [
	outer at: #dad put: 'donald'.
	inner at: #son put: 'riri'.
	self should: [ outer at: #nodad ] raise: KeyNotFound.
	self should: [ outer at: #noson ] raise: KeyNotFound.
	self should: [ inner at: #nodad ] raise: KeyNotFound
]

{ #category : #tests }
PEnvironmentTest >> testSetAtRightLevel [
	
	outer at: #dad put: 'donald'.
	inner at: #son put: 'riri'.
	self assert: (inner at: #son) = 'riri'.
	inner lookupAt: #son put: 'fifi'.
	
	self assert: (outer at: #dad) = 'donald'.
	outer lookupAt: #dad put: 'piscou'.
	self assert: (outer at: #dad) = 'piscou'.
]

{ #category : #tests }
PEnvironmentTest >> testSetLookup [
	outer at: #dad put: 'donald'.
	inner at: #son put: 'riri'.
	self assert: (inner at: #dad) = 'donald'.
	inner lookupAt: #dad put: 'picsou'.
	self assert: (outer at: #dad) = 'picsou'.
	self assert: (inner at: #dad) = 'picsou'.
	self deny: (inner keys includes: #dad)
	
]
