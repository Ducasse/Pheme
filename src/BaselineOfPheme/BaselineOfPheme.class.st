Class {
	#name : #BaselineOfPheme,
	#superclass : #BaselineOf,
	#category : #BaselineOfPheme
}

{ #category : #baselines }
BaselineOfPheme >> baseline: spec [
	<baseline>
	
	spec for: #'pharo' do: [
		spec package: #'Pheme' ]
]
