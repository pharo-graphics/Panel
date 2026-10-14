Class {
	#name : 'LpTempPanel',
	#superclass : 'LpElement',
	#instVars : [
		'title',
		'header',
		'titleLabel',
		'content'
	],
	#category : 'Panel-Elements',
	#package : 'Panel',
	#tag : 'Elements'
}

{ #category : 'initialization' }
LpTempPanel class >> title: aString content: anElement [

	^ self new
		title: aString;
		content: anElement;
		yourself.
]

{ #category : 'accessing' }
LpTempPanel >> close [

	self dockChild ifNotNil: [ :aDockChild | aDockChild content: nil ].
]

{ #category : 'initialization' }
LpTempPanel >> content [

	^ content.

]

{ #category : 'initialization' }
LpTempPanel >> content: x [

	content ifNotNil: [ :old | old hasParent ifTrue: [ old removeFromParent ] ].
	content := x.
	x ifNotNil: [ :a |
		a hasParent ifTrue: [ a removeFromParent ].
		a constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent.
			c linear weight: 1 ].
		self addChild: a ].

]

{ #category : 'accessing' }
LpTempPanel >> header [

	^ header.
]

{ #category : 'accessing' }
LpTempPanel >> header: anObject [

	header := anObject
]

{ #category : 'initialization' }
LpTempPanel >> initialize [

	super initialize.
	title := 'Untitled'.
	self layout: BlLinearLayout vertical.
	self beMatchParent.
	self background: self theme panelBackground.
	header := self newHeader.
	self addChild: header.
	self initializeDragHandlers.
]

{ #category : 'initialization' }
LpTempPanel >> initializeDragHandlers [

	header addEventHandlerOn: BlDragStartEvent do: [ :anEvent |
		self dock ifNotNil: [ :aDock |
			anEvent consume.
			aDock beginDragging: self from: header at: anEvent position ] ].
	header addEventHandlerOn: BlDragEvent do: [ :anEvent |
		anEvent consume.
		self dock ifNotNil: [ :aDock | aDock dragMovedTo: anEvent position ] ].
	header addEventHandlerOn: BlDragEndEvent do: [ :anEvent |
		anEvent consume.
		self dock ifNotNil: [ :aDock | aDock endDragging ] ].
]

{ #category : 'initialization' }
LpTempPanel >> newCloseButton [

	| btn |
	btn := self newLabel: '×' color: self theme textColor.
	btn constraintsDo: [ :c | c linear vertical alignCenter ].
	btn addEventHandlerOn: BlClickEvent do: [ :anEvent |
		anEvent consume.
		self close ].
	btn addEventHandlerOn: BlDragStartEvent do: [ :anEvent | anEvent consume ].
	^ btn.

]

{ #category : 'initialization' }
LpTempPanel >> newHeader [

	| bar spacer |
	bar := BlElement new
		layout: BlLinearLayout horizontal;
		background: self theme headerBackground;
		padding: (BlInsets horizontal: 8);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical exact: self theme headerHeight.
			c linear weight: 0 ];
		yourself.
	titleLabel := self newLabel: title color: self theme textColor.
	titleLabel constraintsDo: [ :c | c linear vertical alignCenter ].
	spacer := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent.
			c linear weight: 1 ];
		yourself.
	bar addChild: titleLabel.
	bar addChild: spacer.
	bar addChild: self newCloseButton.
	^ bar.

]

{ #category : 'accessing' }
LpTempPanel >> title [

	^ title.
]

{ #category : 'accessing' }
LpTempPanel >> title: aString [

	title := aString.
	titleLabel ifNotNil: [ :label | label text: (self theme text: aString color: self theme textColor) ].
]

{ #category : 'accessing' }
LpTempPanel >> titleLabel [

	^ titleLabel
]

{ #category : 'accessing' }
LpTempPanel >> titleLabel: anObject [

	titleLabel := anObject
]
