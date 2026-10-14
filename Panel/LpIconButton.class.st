Class {
	#name : 'LpIconButton',
	#superclass : 'LpElement',
	#instVars : [
		'icon',
		'action',
		'hovered'
	],
	#category : 'Panel-Elements',
	#package : 'Panel',
	#tag : 'Elements'
}

{ #category : 'accessing' }
LpIconButton >> action [

	^ action.
]

{ #category : 'accessing' }
LpIconButton >> action: aBlock [

	action := aBlock.
]

{ #category : 'accessing' }
LpIconButton >> hovered [

	^ hovered
]

{ #category : 'accessing' }
LpIconButton >> hovered: anObject [

	hovered := anObject
]

{ #category : 'accessing' }
LpIconButton >> icon [

	^ icon.
]

{ #category : 'accessing' }
LpIconButton >> icon: anElement [

	icon ifNotNil: [ :old | old hasParent ifTrue: [ old removeFromParent ] ].
	icon := anElement.
	anElement constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].
	self addChild: anElement.
]

{ #category : 'initialization' }
LpIconButton >> initialize [

	super initialize.
	hovered := false.
	self layout: BlFrameLayout new.
	self constraintsDo: [ :c |
		c horizontal exact: self theme toolbarButtonSize.
		c vertical exact: self theme toolbarButtonSize.
		c linear weight: 0 ].
	self geometry: (BlRoundedRectangleGeometry cornerRadius: 4).
	self background: Color transparent.
	self addEventHandlerOn: BlClickEvent do: [ :anEvent |
		anEvent isConsumed ifFalse: [
			anEvent consume.
			self performAction ] ].
	self addEventHandlerOn: BlMouseEnterEvent do: [ :anEvent |
		hovered := true.
		self updateVisuals ].
	self addEventHandlerOn: BlMouseLeaveEvent do: [ :anEvent |
		hovered := false.
		self updateVisuals ].
]

{ #category : 'accessing' }
LpIconButton >> isHovered [

	^ hovered.
]

{ #category : 'accessing' }
LpIconButton >> performAction [

	action ifNotNil: [ :aBlock | aBlock cull: self ].
]

{ #category : 'accessing' }
LpIconButton >> updateVisuals [

	self background: (hovered
			 ifTrue: [ self theme buttonHoverBackground ]
			 ifFalse: [ Color transparent ]).
]
