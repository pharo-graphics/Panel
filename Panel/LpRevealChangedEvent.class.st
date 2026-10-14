Class {
	#name : 'LpRevealChangedEvent',
	#superclass : 'LpEvent',
	#instVars : [
		'area',
		'revealed'
	],
	#category : 'Panel-Events',
	#package : 'Panel',
	#tag : 'Events'
}

{ #category : 'accessing' }
LpRevealChangedEvent >> area [

	^ area
]

{ #category : 'accessing' }
LpRevealChangedEvent >> area: anArea [

	area := anArea.
]

{ #category : 'accessing' }
LpRevealChangedEvent >> revealed [

	^ revealed
]

{ #category : 'accessing' }
LpRevealChangedEvent >> revealed: aBoolean [

	revealed := aBoolean
]
