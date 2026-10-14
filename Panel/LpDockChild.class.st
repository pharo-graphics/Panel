Class {
	#name : 'LpDockChild',
	#superclass : 'LpResizer',
	#instVars : [
		'revealed',
		'areaContent',
		'contentFrame',
		'dropOverlay',
		'rail',
		'emptyPlaceholder',
		'dragMode',
		'dropHovered'
	],
	#category : 'Panel-Elements',
	#package : 'Panel',
	#tag : 'Elements'
}

{ #category : 'accessing' }
LpDockChild >> applyConstraints [

	area isCenter ifTrue: [ ^ super applyConstraints ].
	self isCollapsed ifTrue: [ ^ self applyAxisSize: self theme railThickness ].
	self isDropZone ifTrue: [ ^ self applyAxisSize: self theme dropZoneSize ].
	super applyConstraints.
]

{ #category : 'accessing' }
LpDockChild >> area: anArea [

	super area: anArea.
	self dragPosition: (anArea defaultSizeIn: self theme).
	emptyPlaceholder := self newEmptyPlaceholder.
	rail := self newRail.
	dropOverlay := self newDropOverlay.
	contentFrame := BlElement new
		layout: BlFrameLayout new;
		yourself.
	contentFrame addChild: emptyPlaceholder.
	contentFrame addChild: rail.
	contentFrame addChild: dropOverlay.
	self child: contentFrame.
	self updateVisibility.
]

{ #category : 'accessing' }
LpDockChild >> areaContent [

	^ areaContent
]

{ #category : 'accessing' }
LpDockChild >> areaContent: anObject [

	areaContent := anObject
]

{ #category : 'accessing' }
LpDockChild >> content [

	^ areaContent.

]

{ #category : 'accessing' }
LpDockChild >> content: aPanelOrNil [

	(areaContent notNil and: [ areaContent parent == contentFrame ]) ifTrue: [
		contentFrame removeChild: areaContent ].
	areaContent := aPanelOrNil.
	aPanelOrNil ifNotNil: [ :aPanel |
		aPanel hasParent ifTrue: [ aPanel removeFromParent ].
		aPanel constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ].
		contentFrame addChild: aPanel at: 1 ].
	self updateVisibility.

]

{ #category : 'accessing' }
LpDockChild >> contentFrame [

	^ contentFrame.

]

{ #category : 'accessing' }
LpDockChild >> contentFrame: anObject [

	contentFrame := anObject
]

{ #category : 'accessing' }
LpDockChild >> dragEntered [

	dragMode ifFalse: [ ^ self ].
	dropHovered := true.
	self dragSession ifNotNil: [ :session | session hoveredChild: self ].
	self updateDropOverlay.
]

{ #category : 'accessing' }
LpDockChild >> dragLeft [

	dropHovered := false.
	self dragSession ifNotNil: [ :session |
		(session isHovering: self) ifTrue: [ session hoveredChild: nil ] ].
	self updateDropOverlay.
]

{ #category : 'accessing' }
LpDockChild >> dragMode [

	^ dragMode
]

{ #category : 'accessing' }
LpDockChild >> dragMode: anObject [

	dragMode := anObject
]

{ #category : 'accessing' }
LpDockChild >> dragSession [

	^ self dock ifNotNil: [ :aDock | aDock dragSession ].
]

{ #category : 'accessing' }
LpDockChild >> dropHovered [

	^ dropHovered
]

{ #category : 'accessing' }
LpDockChild >> dropHovered: anObject [

	dropHovered := anObject
]

{ #category : 'accessing' }
LpDockChild >> dropOverlay [

	^ dropOverlay.
]

{ #category : 'accessing' }
LpDockChild >> dropOverlay: anObject [

	dropOverlay := anObject
]

{ #category : 'accessing' }
LpDockChild >> emptyPlaceholder [

	^ emptyPlaceholder.

]

{ #category : 'accessing' }
LpDockChild >> emptyPlaceholder: anObject [

	emptyPlaceholder := anObject
]

{ #category : 'accessing' }
LpDockChild >> enterDragMode [

	dragMode := true.
	dropHovered := false.
	self updateVisibility.
]

{ #category : 'accessing' }
LpDockChild >> exitDragMode [

	dragMode := false.
	dropHovered := false.
	self updateVisibility.
]

{ #category : 'initialization' }
LpDockChild >> initialize [

	revealed := true.
	dragMode := false.
	dropHovered := false.
	super initialize.
	self background: self theme panelBackground.
	self addEventHandler: LpDropHandler new.
]

{ #category : 'accessing' }
LpDockChild >> isCollapsed [

	^ area isEdge and: [ dragMode not and: [ revealed not ] ].
]

{ #category : 'accessing' }
LpDockChild >> isDropHovered [

	^ dropHovered.
]

{ #category : 'accessing' }
LpDockChild >> isDropZone [

	^ area isEdge and: [ dragMode and: [ revealed not ] ].
]

{ #category : 'accessing' }
LpDockChild >> isEmpty [

	^ areaContent isNil.

]

{ #category : 'accessing' }
LpDockChild >> isInDragMode [

	^ dragMode.
]

{ #category : 'accessing' }
LpDockChild >> isRevealed [

	^ revealed.
]

{ #category : 'accessing' }
LpDockChild >> lpReservedSizeAlong: anArea [

	self isCollapsed ifTrue: [ ^ self theme railThickness ].
	self isDropZone ifTrue: [ ^ self theme dropZoneSize ].
	^ super lpReservedSizeAlong: anArea.
]

{ #category : 'accessing' }
LpDockChild >> newDropOverlay [

	^ BlElement new
		background: self theme dropZoneColor;
		visibility: BlVisibility gone;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		yourself.
]

{ #category : 'accessing' }
LpDockChild >> newEmptyPlaceholder [

	| label column placeholder |
	label := self newLabel: 'Empty' color: self theme placeholderColor.
	label constraintsDo: [ :c | c linear horizontal alignCenter ].
	column := BlElement new
		layout: (BlLinearLayout vertical cellSpacing: 10);
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent.
			c frame horizontal alignCenter.
			c frame vertical alignCenter ];
		yourself.
	column addChild: label.
	column addChild: self newPlaygroundButton.
	placeholder := BlElement new
		layout: BlFrameLayout new;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		yourself.
	placeholder addChild: column.
	^ placeholder.
]

{ #category : 'accessing' }
LpDockChild >> newPlaygroundButton [

	| button |
	button := self newLabel: '+ Playground' color: self theme textColor.
	button
		padding: (BlInsets horizontal: 10 vertical: 4);
		border: (BlBorder paint: self theme borderColor width: 1);
		geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		background: Color transparent;
		mouseCursor: Cursor webLink.
	button constraintsDo: [ :c | c linear horizontal alignCenter ].
	button addEventHandlerOn: BlClickEvent do: [ :anEvent |
		anEvent consume.
		self dock ifNotNil: [ :aDock | aDock newPlaygroundIn: area ] ].
	button addEventHandlerOn: BlMouseEnterEvent do: [ :anEvent | button background: self theme headerBackground ].
	button addEventHandlerOn: BlMouseLeaveEvent do: [ :anEvent | button background: Color transparent ].
	^ button.
]

{ #category : 'initialization' }
LpDockChild >> newRail [

	| aRail |
	aRail := BlElement new
		background: self theme railColor;
		visibility: BlVisibility gone;
		mouseCursor: Cursor webLink;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		yourself.
	aRail addEventHandlerOn: BlClickEvent do: [ :anEvent |
		anEvent consume.
		self reveal: true ].
	aRail addEventHandlerOn: BlMouseEnterEvent do: [ :anEvent | aRail background: self theme railHoverColor ].
	aRail addEventHandlerOn: BlMouseLeaveEvent do: [ :anEvent | aRail background: self theme railColor ].
	^ aRail.
]

{ #category : 'accessing' }
LpDockChild >> rail [

	^ rail
]

{ #category : 'accessing' }
LpDockChild >> rail: anObject [

	rail := anObject
]

{ #category : 'accessing' }
LpDockChild >> receiveDroppedWidget: p [

	| src ele |
	self reveal: true.
	src := p dockChild.
	src == self ifTrue: [ ^ p ].
	ele := areaContent.
	src ifNotNil: [ :dc | dc content: nil ].
	self content: p.
	(src notNil and: [ ele notNil ]) ifTrue: [ src content: ele ].
	^ p.
]

{ #category : 'accessing' }
LpDockChild >> reveal: aBoolean [

	area isCenter ifTrue: [ ^ self ].
	revealed = aBoolean ifTrue: [ ^ self ].
	revealed := aBoolean.
	self updateVisibility.
	self fireEvent: (LpRevealChangedEvent new
			 area: area;
			 revealed: aBoolean;
			 yourself).
]

{ #category : 'accessing' }
LpDockChild >> revealed [

	^ revealed.
]

{ #category : 'accessing' }
LpDockChild >> revealed: anObject [

	revealed := anObject
]

{ #category : 'accessing' }
LpDockChild >> showCollapsed [

	areaContent ifNotNil: [ :panel | panel visibility: BlVisibility gone ].
	emptyPlaceholder visibility: BlVisibility gone.
	rail visibility: BlVisibility visible.
	self handleVisible: false
]

{ #category : 'accessing' }
LpDockChild >> showExpanded [

	areaContent ifNotNil: [ :panel | panel visibility: BlVisibility visible ].
	emptyPlaceholder visibility: (self isEmpty
			ifTrue: [ BlVisibility visible ]
			ifFalse: [ BlVisibility gone ]).
	rail visibility: BlVisibility gone.
	self handleVisible: area isEdge.
]

{ #category : 'accessing' }
LpDockChild >> toggle [

	self reveal: revealed not.
]

{ #category : 'accessing' }
LpDockChild >> updateChildrenVisibility [

	contentFrame ifNil: [ ^ self ].
	self isCollapsed
		ifTrue: [ self showCollapsed ]
		ifFalse: [ self showExpanded ].
	self updateDropOverlay.
]

{ #category : 'accessing' }
LpDockChild >> updateDropOverlay [

	dropOverlay ifNil: [ ^ self ].
	dropOverlay visibility: (dragMode
			 ifTrue: [ BlVisibility visible ]
			 ifFalse: [ BlVisibility gone ]).
	dropOverlay background: (dropHovered
			 ifTrue: [ self theme dropZoneHoverColor ]
			 ifFalse: [ self theme dropZoneColor ]).
]

{ #category : 'accessing' }
LpDockChild >> updateVisibility [

	self updateChildrenVisibility.
	self applyConstraints.
]
