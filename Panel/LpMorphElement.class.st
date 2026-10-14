Class {
	#name : 'LpMorphElement',
	#superclass : 'LpElement',
	#instVars : [
		'morph',
		'hostMorph',
		'fallbackLabel'
	],
	#category : 'Panel-Elements',
	#package : 'Panel',
	#tag : 'Elements'
}

{ #category : 'accessing' }
LpMorphElement class >> morph: aMorph [

	^ self new
		morph: aMorph;
		yourself.
]

{ #category : 'instance creation' }
LpMorphElement class >> newPlaygroundMorph [

	^ (Smalltalk globals at: #StPlaygroundPresenter ifAbsent: [ ^ nil ]) new build.
]

{ #category : 'accessing' }
LpMorphElement class >> playground [

	^ self morph: self newPlaygroundMorph.
]

{ #category : 'accessing' }
LpMorphElement >> attachMorphTo: aHostMorph [

	self detachMorph.
	hostMorph := aHostMorph.
	aHostMorph owner addMorphFront: morph.
]

{ #category : 'accessing' }
LpMorphElement >> beMouseTransparent: aBoolean [

	morph ifNotNil: [ :aMorph |
		aBoolean
			ifTrue: [ aMorph lock ]
			ifFalse: [ aMorph unlock ] ].
]

{ #category : 'accessing' }
LpMorphElement >> detachMorph [

	morph ifNotNil: [ :aMorph | aMorph owner ifNotNil: [ aMorph delete ] ].
	hostMorph := nil.
]

{ #category : 'accessing' }
LpMorphElement >> fallbackLabel [

	^ fallbackLabel
]

{ #category : 'accessing' }
LpMorphElement >> fallbackLabel: anObject [

	fallbackLabel := anObject
]

{ #category : 'accessing' }
LpMorphElement >> fallbackText [

	^ 'playground opened'.
]

{ #category : 'accessing' }
LpMorphElement >> hasMorph [

	^ morph notNil.
]

{ #category : 'accessing' }
LpMorphElement >> hostMorph [

	^ hostMorph.
]

{ #category : 'accessing' }
LpMorphElement >> hostMorph: anObject [

	hostMorph := anObject
]

{ #category : 'initialization' }
LpMorphElement >> initialize [

	super initialize.
	self layout: BlFrameLayout new.
	self beMatchParent.
	self background: self theme editorBackground.
	fallbackLabel := self newLabel: self fallbackText color: self theme placeholderColor.
	fallbackLabel constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].
	self addChild: fallbackLabel.
	self addEventHandlerOn: BlElementAddedToSceneGraphEvent do: [ :anEvent | self syncMorph ].
	self addEventHandlerOn: BlElementRemovedFromSceneGraphEvent do: [ :anEvent | self detachMorph ].
	self addEventHandlerOn: BlElementPositionInSpaceChangedEvent do: [ :anEvent | self syncMorph ].
	self addEventHandlerOn: BlElementExtentChangedEvent do: [ :anEvent | self syncMorph ].
]

{ #category : 'accessing' }
LpMorphElement >> isAttachedToMorphicHost [

	^ hostMorph notNil and: [ morph notNil and: [ morph owner notNil and: [ morph owner == hostMorph owner ] ] ].
]

{ #category : 'accessing' }
LpMorphElement >> isShownInDock [

	self isAttachedToSceneGraph ifFalse: [ ^ false ].
	(self withAllParents allSatisfy: [ :each | each visibility isVisible ]) ifFalse: [ ^ false ].
	^ self dock
		  ifNil: [ true ]
		  ifNotNil: [ :aDock | aDock areMorphsSuppressed not ].
]

{ #category : 'accessing' }
LpMorphElement >> morph [

	^ morph.
]

{ #category : 'accessing' }
LpMorphElement >> morph: aMorphOrNil [

	self detachMorph.
	morph := aMorphOrNil.
	aMorphOrNil ifNotNil: [ :aMorph |
		aMorph on: #mouseEnter send: #pointerEnteredMorph to: self.
		aMorph on: #mouseLeave send: #pointerLeftMorph to: self ].
	fallbackLabel text: (self theme
			text: (aMorphOrNil
					ifNil: [ 'Tool not available' ]
					ifNotNil: [ self fallbackText ])
			color: self theme placeholderColor).
	self syncMorph.
]

{ #category : 'accessing' }
LpMorphElement >> morphBounds [

	^ (hostMorph position + self positionInSpace rounded) extent: self extent rounded.
]

{ #category : 'accessing' }
LpMorphElement >> pointerEnteredMorph [

	self space ifNotNil: [ :aSpace |
		aSpace dispatchEvent: BlSpaceMouseLeaveEvent new.
		aSpace currentCursor: nil ].
]

{ #category : 'accessing' }
LpMorphElement >> pointerLeftMorph [

	self space ifNotNil: [ :aSpace |
		aSpace enqueueTask: (BlTaskAction new action: [ aSpace currentCursor: aSpace currentCursor ]) ].
]

{ #category : 'accessing' }
LpMorphElement >> syncMorph [

	| host |
	morph ifNil: [ ^ self ].
	host := self dock ifNotNil: [ :aDock | aDock hostMorph ].
	(host isNil or: [ host owner isNil ]) ifTrue: [ ^ self detachMorph ].
	hostMorph == host ifFalse: [ self attachMorphTo: host ].
	self isShownInDock
		ifTrue: [
			morph bounds: self morphBounds.
			morph show ]
		ifFalse: [ morph hide ].
]
