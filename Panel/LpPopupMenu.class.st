Class {
	#name : 'LpPopupMenu',
	#superclass : 'LpElement',
	#instVars : [
		'dock',
		'items'
	],
	#category : 'Panel-Elements',
	#package : 'Panel',
	#tag : 'Elements'
}

{ #category : 'initialization' }
LpPopupMenu class >> dock: aDock items: aCollection [

	^ self new
		dock: aDock items: aCollection;
		yourself.
]

{ #category : 'accessing' }
LpPopupMenu >> dock [

	^ dock
]

{ #category : 'accessing' }
LpPopupMenu >> dock: anObject [

	dock := anObject
]

{ #category : 'accessing' }
LpPopupMenu >> dock: aDock items: aCollection [

	dock := aDock.
	items := aCollection asArray.
	self removeChildren.
	items do: [ :each | self addChild: (self newRowFor: each) ].

]

{ #category : 'initialization' }
LpPopupMenu >> initialize [

	super initialize.
	self layout: BlLinearLayout vertical.
	self constraintsDo: [ :c |
		c horizontal exact: self theme menuWidth.
		c vertical fitContent ].
	self padding: (BlInsets all: 4).
	self geometry: (BlRoundedRectangleGeometry cornerRadius: 6).
	self background: self theme menuBackground.
	self border: (BlBorder paint: self theme borderColor width: 1).
	self outskirts: BlOutskirts inside.
]

{ #category : 'accessing' }
LpPopupMenu >> items [

	^ items.
]

{ #category : 'accessing' }
LpPopupMenu >> items: anObject [

	items := anObject
]

{ #category : 'accessing' }
LpPopupMenu >> newRowFor: anItem [

	| ele label |
	label := self newLabel: anItem label color: self theme textColor.
	label constraintsDo: [ :c | c linear vertical alignCenter ].
	ele := BlElement new
		layout: BlLinearLayout horizontal;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical exact: self theme menuItemHeight.
			c linear weight: 0 ];
		padding: (BlInsets horizontal: 10);
		geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		background: Color transparent;
		addChild: label;
		yourself.
	ele addEventHandlerOn: BlMouseEnterEvent do: [ :anEvent | ele background: self theme menuHoverBackground ].
	ele addEventHandlerOn: BlMouseLeaveEvent do: [ :anEvent | ele background: Color transparent ].
	ele addEventHandlerOn: BlClickEvent do: [ :anEvent |
		anEvent consume.
		dock closePopup.
		anItem perform ].
	^ ele.
]

{ #category : 'accessing' }
LpPopupMenu >> rows [

	^ self children asArray.
]
