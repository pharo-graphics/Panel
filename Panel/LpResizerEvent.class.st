Class {
	#name : 'LpResizerEvent',
	#superclass : 'LpEvent',
	#instVars : [
		'resizer',
		'dragPosition'
	],
	#category : 'Panel-Events',
	#package : 'Panel',
	#tag : 'Events'
}

{ #category : 'accessing' }
LpResizerEvent >> dragPosition [

	^ dragPosition
]

{ #category : 'accessing' }
LpResizerEvent >> dragPosition: anObject [

	dragPosition := anObject
]

{ #category : 'accessing' }
LpResizerEvent >> resizer [

	^ resizer
]

{ #category : 'accessing' }
LpResizerEvent >> resizer: anObject [

	resizer := anObject
]
