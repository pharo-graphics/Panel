Class {
	#name : 'LpHeaderBar',
	#superclass : 'LpElement',
	#instVars : [
		'dock',
		'titleLabel',
		'menuButton',
		'toggles'
	],
	#category : 'Panel-Elements',
	#package : 'Panel',
	#tag : 'Elements'
}

{ #category : 'accessing' }
LpHeaderBar class >> dock: aDock [

	^ self new
		dock: aDock;
		yourself.
]

{ #category : 'accessing' }
LpHeaderBar >> dock [

	^ dock.
]

{ #category : 'accessing' }
LpHeaderBar >> dock: aDock [

	dock := aDock.
	self removeChildren.
	titleLabel := self newTitleLabel.
	menuButton := self newMenuButton.
	toggles := self toggleAreas collect: [ :each | self newToggleFor: each ].
	self addChild: titleLabel.
	self addChild: self newSpacer.
	self addChild: menuButton.
	self addChildren: toggles.
]

{ #category : 'initialization' }
LpHeaderBar >> initialize [

	super initialize.
	toggles := OrderedCollection new.
	self layout: (BlLinearLayout horizontal cellSpacing: 2).
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical exact: self theme headerBarHeight.
		c linear weight: 0 ].
	self padding: (BlInsets horizontal: 8).
	self background: self theme headerBackground.
]

{ #category : 'accessing' }
LpHeaderBar >> menuButton [

	^ menuButton
]

{ #category : 'accessing' }
LpHeaderBar >> menuButton: anObject [

	menuButton := anObject
]

{ #category : 'accessing' }
LpHeaderBar >> newMenuButton [

	| button |
	button := LpIconButton new.
	button icon: LpMenuIcon new.
	button action: [ dock showMenu ].
	button constraintsDo: [ :c | c linear vertical alignCenter ].
	^ button.
]

{ #category : 'accessing' }
LpHeaderBar >> newMenuIcon [

	| icon |
	icon := BlElement new
		layout: (BlLinearLayout vertical cellSpacing: 3);
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ];
		yourself.
	3 timesRepeat: [
		icon addChild: (BlElement new
				 geometry: BlCircleGeometry new;
				 background: self theme iconActiveColor;
				 constraintsDo: [ :c |
					 c horizontal exact: 3.
					 c vertical exact: 3.
					 c linear weight: 0 ];
				 yourself) ].
	^ icon.
]

{ #category : 'accessing' }
LpHeaderBar >> newSpacer [

	^ BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent.
			c linear weight: 1 ];
		yourself.
]

{ #category : 'accessing' }
LpHeaderBar >> newTitleLabel [

	| label |
	label := self newLabel: 'LibPanel' color: self theme textColor.
	label constraintsDo: [ :c | c linear vertical alignCenter ].
	^ label.
]

{ #category : 'accessing' }
LpHeaderBar >> newToggleFor: anArea [

	| button |
	button := LpAreaToggleButton area: anArea dock: dock.
	button constraintsDo: [ :c | c linear vertical alignCenter ].
	^ button.
]

{ #category : 'accessing' }
LpHeaderBar >> title: aString [

	titleLabel text: (self theme text: aString color: self theme textColor).

]

{ #category : 'accessing' }
LpHeaderBar >> titleLabel [

	^ titleLabel.
]

{ #category : 'accessing' }
LpHeaderBar >> titleLabel: anObject [

	titleLabel := anObject
]

{ #category : 'accessing' }
LpHeaderBar >> toggleAreas [

	^ { LpArea start. LpArea bottom. LpArea end. LpArea top }.
]

{ #category : 'accessing' }
LpHeaderBar >> toggleFor: anArea [

	^ toggles detect: [ :each | each area == anArea ] ifNone: [ nil ].
]

{ #category : 'accessing' }
LpHeaderBar >> toggles [

	^ toggles asArray.
]

{ #category : 'accessing' }
LpHeaderBar >> toggles: anObject [

	toggles := anObject
]

{ #category : 'accessing' }
LpHeaderBar >> updateToggles [

	toggles do: [ :each | each updateState ].
]
