Class {
	#name : 'LpPaned',
	#superclass : 'LpElement',
	#instVars : [
		'orientationArea'
	],
	#category : 'Panel-Elements',
	#package : 'Panel',
	#tag : 'Elements'
}

{ #category : 'factory' }
LpPaned class >> horizontal [

	^ self new
		beHorizontal;
		yourself.
]

{ #category : 'factory' }
LpPaned class >> vertical [

	^ self new
		beVertical;
		yourself.
]

{ #category : 'accessing' }
LpPaned >> append: anElement [

	^ self insert: anElement at: self children size + 1.
]

{ #category : 'initialization' }
LpPaned >> beHorizontal [

	orientationArea := LpArea start.
	self layout: BlLinearLayout horizontal.
]

{ #category : 'initialization' }
LpPaned >> beVertical [

	orientationArea := LpArea top.
	self layout: BlLinearLayout vertical.
]

{ #category : 'initialization' }
LpPaned >> initialize [

	super initialize.
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent.
		c linear weight: 1 ].
	self beHorizontal.
]

{ #category : 'accessing' }
LpPaned >> insert: anElement at: x [

	| ele |
	ele := LpResizer area: orientationArea child: anElement.
	self addChild: ele at: x.
	self updateHandles.
	^ anElement.
]

{ #category : 'accessing' }
LpPaned >> isEmpty [

	^ self hasChildren not.
]

{ #category : 'accessing' }
LpPaned >> isHorizontal [

	^ orientationArea isHorizontal.
]

{ #category : 'accessing' }
LpPaned >> isVertical [

	^ self isHorizontal not.
]

{ #category : 'accessing' }
LpPaned >> orientationArea [

	^ orientationArea
]

{ #category : 'accessing' }
LpPaned >> orientationArea: anObject [

	orientationArea := anObject
]

{ #category : 'accessing' }
LpPaned >> panes [

	^ self children asArray collect: [ :each | each child ].
]

{ #category : 'accessing' }
LpPaned >> remove: anElement [

	| ele |
	ele := self resizerFor: anElement.
	ele ifNil: [ ^ anElement ].
	self removeChild: ele.
	ele child: nil.
	self updateHandles.
	^ anElement.
]

{ #category : 'accessing' }
LpPaned >> resizerFor: anElement [

	^ self children detect: [ :each | each child == anElement ] ifNone: [ nil ].
]

{ #category : 'accessing' }
LpPaned >> resizers [

	^ self children.
]

{ #category : 'accessing' }
LpPaned >> updateHandles [

	self hasChildren ifFalse: [ ^ self ].
	self children do: [ :each | each handleVisible: true ].
	self lastChild handleVisible: false.
	self lastChild beFlexible.
]
