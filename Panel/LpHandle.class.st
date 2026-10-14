Class {
	#name : 'LpHandle',
	#superclass : 'LpElement',
	#instVars : [
		'resizer',
		'state'
	],
	#category : 'Panel-Elements',
	#package : 'Panel',
	#tag : 'Elements'
}

{ #category : 'states' }
LpHandle >> applyArea [

	| anArea |
	anArea := self area.
	self mouseCursor: anArea resizeCursor.
	self constraintsDo: [ :c |
		c linear weight: 0.
		anArea isHorizontal
			ifTrue: [
				c horizontal exact: self thickness.
				c vertical matchParent ]
			ifFalse: [
				c vertical exact: self thickness.
				c horizontal matchParent ] ].
]

{ #category : 'accessing' }
LpHandle >> area [

	^ resizer area.
]

{ #category : 'states' }
LpHandle >> beActive [

	state := #active.
	self background: self theme handleActiveColor.
]

{ #category : 'states' }
LpHandle >> beHovered [

	self isActive ifTrue: [ ^ self ].
	state := #hovered.
	self background: self theme handleHoverColor.
]

{ #category : 'states' }
LpHandle >> beNormal [

	state := #normal.
	self background: self theme handleColor.
]

{ #category : 'initialization' }
LpHandle >> initialize [

	super initialize.
	state := #normal.
	self background: self theme handleColor.
	self addEventHandler: LpResizeHandler new.
]

{ #category : 'accessing' }
LpHandle >> isActive [

	^ state == #active.
]

{ #category : 'accessing' }
LpHandle >> resizer [

	^ resizer
]

{ #category : 'accessing' }
LpHandle >> resizer: aResizer [

	resizer := aResizer.
	self applyArea.
]

{ #category : 'accessing' }
LpHandle >> state [

	^ state
]

{ #category : 'accessing' }
LpHandle >> state: anObject [

	state := anObject
]

{ #category : 'accessing' }
LpHandle >> thickness [

	^ self theme handleThickness.
]
