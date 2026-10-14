Class {
	#name : 'LpDock',
	#superclass : 'LpElement',
	#instVars : [
		'dockChildren',
		'centerColumn',
		'areasRow',
		'body',
		'headerBar',
		'overlay',
		'dragSession',
		'popup',
		'scrim',
		'playgroundCounter',
		'menuItems',
		'playgroundFactory',
		'morphsSuppressed'
	],
	#category : 'Panel-Elements',
	#package : 'Panel',
	#tag : 'Elements'
}

{ #category : 'accessing' }
LpDock >> addMenuItem: aMenuItem [

	self menuItems add: aMenuItem.
]

{ #category : 'morph' }
LpDock >> areMorphsSuppressed [

	^ morphsSuppressed.
]

{ #category : 'accessing' }
LpDock >> areasRow [

	^ areasRow
]

{ #category : 'accessing' }
LpDock >> areasRow: anObject [

	areasRow := anObject
]

{ #category : 'accessing' }
LpDock >> beginDragging: aWidget from: aTab at: aPoint [

	self isDragging ifTrue: [ self endDragging ].
	self closePopup.
	dragSession := LpDragSession widget: aWidget sourceTab: aTab.
	dragSession ghost: (self newGhostFor: aWidget).
	overlay addChild: dragSession ghost.
	self dragMovedTo: aPoint.
	
	
	self dockChildrenDo: [ :each | each enterDragMode ].
	self suppressMorphs: true.
	self fireEvent: (LpDragStartedEvent new
			 widget: aWidget;
			 yourself).
]

{ #category : 'accessing' }
LpDock >> body [

	^ body
]

{ #category : 'accessing' }
LpDock >> body: anObject [

	body := anObject
]

{ #category : 'sizes' }
LpDock >> bottomHeight [

	^ self sizeOfArea: LpArea bottom.
]

{ #category : 'sizes' }
LpDock >> bottomHeight: aNumber [

	self setSize: aNumber ofArea: LpArea bottom.
]

{ #category : 'accessing' }
LpDock >> centerColumn [

	^ centerColumn
]

{ #category : 'accessing' }
LpDock >> centerColumn: anObject [

	centerColumn := anObject
]

{ #category : 'morph' }
LpDock >> closeAllPlaygrounds [

	self panels do: [ :each | each close ].
]

{ #category : 'accessing' }
LpDock >> closePopup [

	popup ifNotNil: [ :anElement | anElement hasParent ifTrue: [ anElement removeFromParent ] ].
	scrim ifNotNil: [ :anElement | anElement hasParent ifTrue: [ anElement removeFromParent ] ].
	popup := nil.
	scrim := nil.
	self suppressMorphs: self isDragging.
]

{ #category : 'accessing' }
LpDock >> defaultMenuItems [

	^ OrderedCollection new
		add: (LpMenuItem label: '+ New playground' action: [ self newPlaygroundIn: LpArea bottom ]);
		add: (LpMenuItem label: '+ New playground in center' action: [ self newPlaygroundIn: LpArea center ]);
		add: (LpMenuItem label: '+ New playground on the left' action: [ self newPlaygroundIn: LpArea start ]);
		add: (LpMenuItem label: 'Close all' action: [ self closeAllPlaygrounds ]);
		yourself.
]

{ #category : 'accessing' }
LpDock >> dock [

	^ self.
]

{ #category : 'accessing' }
LpDock >> dockChildFor: anArea [

	^ dockChildren at: anArea
]

{ #category : 'accessing' }
LpDock >> dockChildren [

	^ dockChildren
]

{ #category : 'accessing' }
LpDock >> dockChildren: anObject [

	dockChildren := anObject
]

{ #category : 'accessing' }
LpDock >> dockChildrenDo: aBlock [

	LpArea all do: [ :each | aBlock value: (self dockChildFor: each) ].
]

{ #category : 'accessing' }
LpDock >> dragMovedTo: aPoint [

	dragSession ifNil: [ ^ self ].
	dragSession ghost position: (overlay globalPointToLocal: aPoint) + (12 @ 12).

]

{ #category : 'accessing' }
LpDock >> dragSession [

	^ dragSession.
]

{ #category : 'accessing' }
LpDock >> dragSession: anObject [

	dragSession := anObject
]

{ #category : 'accessing' }
LpDock >> dropWidgetOn: aDockChild [

	| session |
	session := dragSession ifNil: [ ^ self ].
	aDockChild receiveDroppedWidget: session widget.
	self fireEvent: (LpWidgetMovedEvent new
			widget: session widget;
			fromArea: session sourceArea;
			toArea: aDockChild area;
			yourself).
	self endDragging.

]

{ #category : 'accessing' }
LpDock >> endDragging [

	| session |
	session := dragSession ifNil: [ ^ self ].
	dragSession := nil.
	session ghost ifNotNil: [ :ghost | ghost hasParent ifTrue: [ ghost removeFromParent ] ].
	self dockChildrenDo: [ :each | each exitDragMode ].
	self suppressMorphs: false.
	self fireEvent: (LpDragEndedEvent new
			widget: session widget;
			yourself).
]

{ #category : 'sizes' }
LpDock >> endWidth [

	^ self sizeOfArea: LpArea end.
]

{ #category : 'sizes' }
LpDock >> endWidth: aNumber [

	self setSize: aNumber ofArea: LpArea end.
]

{ #category : 'morph' }
LpDock >> firstFreeArea [

	^ LpArea all
		detect: [ :each | (self dockChildFor: each) isEmpty ]
		ifNone: [ nil ].
]

{ #category : 'accessing' }
LpDock >> hasPopup [

	^ popup notNil.
]

{ #category : 'accessing' }
LpDock >> headerBar [

	^ headerBar
]

{ #category : 'accessing' }
LpDock >> headerBar: anObject [

	headerBar := anObject
]

{ #category : 'morph' }
LpDock >> hostMorph [

	self isAttachedToSceneGraph ifFalse: [ ^ nil ].
	^ self space hostSpace ifNotNil: [ :aHostSpace |
		  (aHostSpace respondsTo: #spaceHostMorph)
			  ifTrue: [ aHostSpace spaceHostMorph ]
			  ifFalse: [ nil ] ].
]

{ #category : 'initialization' }
LpDock >> initialize [

	super initialize.
	self layout: BlFrameLayout new.
	self beMatchParent.
	self background: self theme windowBackground.
	playgroundCounter := 0.
	morphsSuppressed := false.
	self initializeAreas.
	self initializeBody.
	self initializeOverlay.
	self initializeEventHandlers.
]

{ #category : 'initialization' }
LpDock >> initializeAreas [

	dockChildren := Dictionary new.
	LpArea all do: [ :each |
		dockChildren at: each put: (LpDockChild area: each) ].
	centerColumn := BlElement new
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent.
			c linear weight: 1 ];
		yourself.
	centerColumn addChildren: {
			(self dockChildFor: LpArea top).
			(self dockChildFor: LpArea center).
			(self dockChildFor: LpArea bottom) }.
	areasRow := BlElement new
		layout: BlLinearLayout horizontal;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent.
			c linear weight: 1 ];
		yourself.
	areasRow addChildren: {
			(self dockChildFor: LpArea start).
			centerColumn.
			(self dockChildFor: LpArea end) }.
]

{ #category : 'initialization' }
LpDock >> initializeBody [

	headerBar := LpHeaderBar dock: self.
	body := BlElement new
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		yourself.
	body addChild: headerBar.
	body addChild: areasRow.
	self addChild: body.
]

{ #category : 'initialization' }
LpDock >> initializeEventHandlers [

	self addEventHandlerOn: LpRevealChangedEvent do: [ :anEvent | headerBar updateToggles ].
	self addEventHandlerOn: LpResizeStartEvent do: [ :anEvent | self morphElementsDo: [ :each | each beMouseTransparent: true ] ].
	self addEventHandlerOn: LpResizeEndEvent do: [ :anEvent | self morphElementsDo: [ :each | each beMouseTransparent: false ] ].
	self whenLayoutedDo: [ self syncMorphElements ].
]

{ #category : 'initialization' }
LpDock >> initializeOverlay [

	overlay := BlElement new
		layout: BlBasicLayout new;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		yourself.
	overlay preventMouseEvents.
	self addChild: overlay.
]

{ #category : 'accessing' }
LpDock >> isBottomRevealed [

	^ self isRevealed: LpArea bottom.
]

{ #category : 'accessing' }
LpDock >> isCollapsed: anArea [

	^ (self dockChildFor: anArea) isCollapsed.
]

{ #category : 'accessing' }
LpDock >> isDragging [

	^ dragSession notNil.
]

{ #category : 'accessing' }
LpDock >> isEndRevealed [

	^ self isRevealed: LpArea end.
]

{ #category : 'accessing' }
LpDock >> isRevealed: anArea [

	^ (self dockChildFor: anArea) isRevealed.
]

{ #category : 'accessing' }
LpDock >> isStartRevealed [

	^ self isRevealed: LpArea start.
]

{ #category : 'accessing' }
LpDock >> isTopRevealed [

	^ self isRevealed: LpArea top.
]

{ #category : 'accessing' }
LpDock >> menuItems [

	^ menuItems ifNil: [ menuItems := self defaultMenuItems ].
]

{ #category : 'accessing' }
LpDock >> menuItems: aCollection [

	menuItems := aCollection asOrderedCollection.
]

{ #category : 'morph' }
LpDock >> morphElementsDo: aBlock [

	self panels do: [ :each |
		(each content isKindOf: LpMorphElement) ifTrue: [ aBlock value: each content ] ].
]

{ #category : 'morph' }
LpDock >> morphsSuppressed [

	^ morphsSuppressed
]

{ #category : 'morph' }
LpDock >> morphsSuppressed: anObject [

	morphsSuppressed := anObject
]

{ #category : 'accessing' }
LpDock >> newGhostFor: aWidget [

	| ghost label |
	label := self newLabel: aWidget title color: Color white.
	ghost := BlElement new
		layout: BlLinearLayout horizontal;
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ];
		padding: (BlInsets horizontal: 12 vertical: 6);
		geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		background: self theme ghostBackground;
		yourself.
	ghost addChild: label.
	ghost preventMeAndChildrenMouseEvents.
	^ ghost.
]

{ #category : 'morph' }
LpDock >> newPlayground [

	^ self newPlaygroundIn: LpArea bottom.
]

{ #category : 'morph' }
LpDock >> newPlaygroundIn: anArea [

	| target panel |
	target := anArea.
	(self dockChildFor: anArea) isEmpty ifFalse: [ target := self firstFreeArea ].
	target ifNil: [ ^ self error: 'Every area already holds a panel; close one first' ].
	playgroundCounter := playgroundCounter + 1.
	panel := LpTempPanel
		title: 'Playground ' , playgroundCounter printString
		content: self playgroundFactory value.
	(self dockChildFor: target) content: panel.
	^ panel.

]

{ #category : 'accessing' }
LpDock >> newScrim [

	| ele |
	ele := BlElement new
		background: Color transparent;
		extent: self extent;
		yourself.
	ele addEventHandlerOn: BlMouseDownEvent do: [ :anEvent |
		anEvent consume.
		self closePopup ].
	^ ele.
]

{ #category : 'accessing' }
LpDock >> overlay [

	^ overlay.
]

{ #category : 'accessing' }
LpDock >> overlay: anObject [

	overlay := anObject
]

{ #category : 'accessing' }
LpDock >> panels [

	^ Array streamContents: [ :stream |
		self dockChildrenDo: [ :each | each content ifNotNil: [ :panel | stream nextPut: panel ] ] ].
]

{ #category : 'morph' }
LpDock >> playgroundCounter [

	^ playgroundCounter.
]

{ #category : 'morph' }
LpDock >> playgroundCounter: anObject [

	playgroundCounter := anObject
]

{ #category : 'morph' }
LpDock >> playgroundFactory [

	^ playgroundFactory ifNil: [ playgroundFactory := [ LpMorphElement playground ] ].
]

{ #category : 'morph' }
LpDock >> playgroundFactory: aBlock [

	playgroundFactory := aBlock.
]

{ #category : 'accessing' }
LpDock >> popup [

	^ popup
]

{ #category : 'accessing' }
LpDock >> popup: anObject [

	popup := anObject
]

{ #category : 'accessing' }
LpDock >> popupPositionBelow: anAnchor [

	| corner local |
	corner := anAnchor localPointToGlobal: anAnchor extent.
	local := overlay globalPointToLocal: corner.
	^ ((local x - self theme menuWidth) max: 0) @ (local y + 4).
]

{ #category : 'accessing' }
LpDock >> reveal: anArea to: aBoolean [

	(self dockChildFor: anArea) reveal: aBoolean.
]

{ #category : 'accessing' }
LpDock >> revealBottom: aBoolean [

	self reveal: LpArea bottom to: aBoolean.
]

{ #category : 'accessing' }
LpDock >> revealEnd: aBoolean [

	self reveal: LpArea end to: aBoolean.
]

{ #category : 'accessing' }
LpDock >> revealStart: aBoolean [

	self reveal: LpArea start to: aBoolean.
]

{ #category : 'accessing' }
LpDock >> revealTop: aBoolean [

	self reveal: LpArea top to: aBoolean.
]

{ #category : 'accessing' }
LpDock >> scrim [

	^ scrim
]

{ #category : 'accessing' }
LpDock >> scrim: anObject [

	scrim := anObject
]

{ #category : 'sizes' }
LpDock >> setSize: aNumber ofArea: anArea [

	(self dockChildFor: anArea) dragPosition: aNumber.
]

{ #category : 'accessing' }
LpDock >> showMenu [

	^ self
		  showPopup: (LpPopupMenu dock: self items: self menuItems)
		  anchoredTo: headerBar menuButton.
]

{ #category : 'accessing' }
LpDock >> showPopup: anElement anchoredTo: anAnchor [

	self closePopup.
	scrim := self newScrim.
	popup := anElement.
	overlay addChild: scrim.
	overlay addChild: popup.
	popup position: (self popupPositionBelow: anAnchor).
	self suppressMorphs: true.
	^ popup.
]

{ #category : 'sizes' }
LpDock >> sizeOfArea: anArea [

	^ (self dockChildFor: anArea) dragPosition.
]

{ #category : 'sizes' }
LpDock >> startWidth [

	^ self sizeOfArea: LpArea start.
]

{ #category : 'sizes' }
LpDock >> startWidth: aNumber [

	self setSize: aNumber ofArea: LpArea start.
]

{ #category : 'morph' }
LpDock >> suppressMorphs: aBoolean [

	morphsSuppressed := aBoolean.
	self syncMorphElements.
]

{ #category : 'morph' }
LpDock >> syncMorphElements [

	self morphElementsDo: [ :each | each syncMorph ].
]

{ #category : 'accessing' }
LpDock >> toggleArea: anArea [

	self reveal: anArea to: (self isRevealed: anArea) not.
]

{ #category : 'sizes' }
LpDock >> topHeight [

	^ self sizeOfArea: LpArea top.
]

{ #category : 'sizes' }
LpDock >> topHeight: aNumber [

	self setSize: aNumber ofArea: LpArea top.
]
