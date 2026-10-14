Class {
	#name : 'LpResizer',
	#superclass : 'LpElement',
	#instVars : [
		'area',
		'child',
		'handle',
		'dragPosition',
		'dragOriginSize'
	],
	#category : 'Panel-Elements',
	#package : 'Panel',
	#tag : 'Elements'
}

{ #category : 'accessing' }
LpResizer class >> area: anArea [

	^ self new
		area: anArea;
		yourself.
]

{ #category : 'accessing' }
LpResizer class >> area: anArea child: anElement [

	^ (self area: anArea)
		child: anElement;
		yourself.
]

{ #category : 'accessing' }
LpResizer >> applyAxisSize: n [
	| axis cross |
		
	self constraintsDo: [ :c |
		axis := area isHorizontal
			ifTrue: [ c horizontal ]
			ifFalse: [ c vertical ].
		cross := area isHorizontal
			ifTrue: [ c vertical ]
			ifFalse: [ c horizontal ].
		cross matchParent.
		n ifNil: [ axis matchParent.
				c linear weight: 1 ]
			ifNotNil: [ :size |
				axis exact: size.
				c linear weight: 0 ] ]
]

{ #category : 'accessing' }
LpResizer >> applyConstraints [

	self applyAxisSize: dragPosition.
]

{ #category : 'accessing' }
LpResizer >> area [

	^ area
]

{ #category : 'accessing' }
LpResizer >> area: anArea [
	area := anArea.
	self layout: anArea newResizerLayout.
	handle resizer: self.
	self handleVisible: anArea isEdge.
	self rebuildChildren.
	self applyConstraints.
]

{ #category : 'accessing' }
LpResizer >> axisExtent [

	^ area axisValueOf: self extent
]

{ #category : 'resizing' }
LpResizer >> beginResize [

	dragOriginSize := self axisExtent.
	self isFlexible ifTrue: [ self dragPosition: dragOriginSize ].
	self fireEvent: (LpResizeStartEvent new
			 resizer: self;
			 dragPosition: dragPosition;
			 yourself)
]

{ #category : 'accessing' }
LpResizer >> child [

	^ child
]

{ #category : 'accessing' }
LpResizer >> child: childElement [

	child ifNotNil: [ :old | old hasParent ifTrue: [ old removeFromParent ] ].
	child := childElement.
	childElement ifNotNil: [ :anElement |
		anElement hasParent ifTrue: [ anElement removeFromParent ].
		anElement constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent.
			c linear weight: 1 ] ].
	self rebuildChildren.
]

{ #category : 'resizing' }
LpResizer >> clampSize: x [

	| min max size |
	min := self minimumSize.
	max := self maximumSize.
	max := max max: min.

	size := x rounded.
	size := size max: min.
	size := size min: max.

	^ size
]

{ #category : 'accessing' }
LpResizer >> dragOriginSize [

	^ dragOriginSize
]

{ #category : 'accessing' }
LpResizer >> dragOriginSize: anObject [

	dragOriginSize := anObject
]

{ #category : 'accessing' }
LpResizer >> dragPosition [

	^ dragPosition
]

{ #category : 'accessing' }
LpResizer >> dragPosition: n [

	dragPosition := n.
	self applyConstraints.
]

{ #category : 'resizing' }
LpResizer >> endResize [

	dragOriginSize := nil.
	self fireEvent: (LpResizeEndEvent new
			 resizer: self;
			 dragPosition: dragPosition;
			 yourself)
]

{ #category : 'accessing' }
LpResizer >> handle [

	^ handle
]

{ #category : 'accessing' }
LpResizer >> handle: anObject [

	handle := anObject
]

{ #category : 'accessing' }
LpResizer >> handleThickness [

	^ self hasVisibleHandle
		ifTrue: [ handle thickness ]
		ifFalse: [ 0 ].
]

{ #category : 'accessing' }
LpResizer >> handleVisible: aBoolean [

	handle visibility: (aBoolean
			 ifTrue: [ BlVisibility visible ]
			 ifFalse: [ BlVisibility gone ])
]

{ #category : 'accessing' }
LpResizer >> hasVisibleHandle [

	^ handle visibility isGone not
]

{ #category : 'initialization' }
LpResizer >> initialize [

	super initialize.
	handle := LpHandle new.
	self area: LpArea start.
]

{ #category : 'accessing' }
LpResizer >> isFixed [

	^ dragPosition notNil
]

{ #category : 'accessing' }
LpResizer >> isFlexible [

	^ dragPosition isNil
]

{ #category : 'resizing' }
LpResizer >> isResizing [

	^ dragOriginSize notNil.
]

{ #category : 'geometry' }
LpResizer >> lpReservedSizeAlong: anArea [

	^ self isFixed
		ifTrue: [ dragPosition ]
		ifFalse: [ self minimumSize ]
]

{ #category : 'geometry' }
LpResizer >> maximumSize [

    | available reserved |

    self hasParent ifFalse: [
        ^ SmallInteger maxVal
    ].

    available := area axisValueOf: self parent extent.
    reserved := 0.

    self parent children do: [ :c |
        c == self ifFalse: [
            c visibility isGone ifFalse: [
                reserved := reserved + (self reservedSizeOf: c)
            ]
        ]
    ].

    ^ available - reserved.
]

{ #category : 'geometry' }
LpResizer >> minimumSize [

	^ self theme panelMinimumSize + self handleThickness
]

{ #category : 'accessing' }
LpResizer >> rebuildChildren [

	self removeChildren.
	area handleFirst
		ifTrue: [
			self addChild: handle.
			child ifNotNil: [ :anElement | self addChild: anElement ] ]
		ifFalse: [
			child ifNotNil: [ :anElement | self addChild: anElement ].
			self addChild: handle ]
]

{ #category : 'geometry' }
LpResizer >> reservedSizeOf: anElement [
	^  (anElement isKindOf: LpResizer)
			ifTrue: [ anElement lpReservedSizeAlong: area]
			ifFalse: [ self theme centerMinimumSize ].
]

{ #category : 'resizing' }
LpResizer >> resizeBy: x [

	dragOriginSize ifNil: [ ^ self ].
	self dragPosition: (self clampSize: dragOriginSize + (area sizeDeltaFor: x)).
	self fireEvent: (LpResizeEvent new
			 resizer: self;
			 dragPosition: dragPosition;
			 yourself)
]
