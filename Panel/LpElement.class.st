Class {
	#name : 'LpElement',
	#superclass : 'BlElement',
	#category : 'Panel-Elements',
	#package : 'Panel',
	#tag : 'Elements'
}

{ #category : 'enumerating' }
LpElement >> ancestorDetect: a ifNone: n [

	| c |
	c := self parent.
	[ c isNil ] whileFalse: [
		(a value: c) ifTrue: [ ^ c ].
		c := c parent ].
	^ n value.
]

{ #category : 'instance creation' }
LpElement >> beMatchParent [

	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ]
]

{ #category : 'enumerating' }
LpElement >> dock [

	^ self ancestorDetect: [ :each | each isKindOf: LpDock ] ifNone: [ nil ]
]

{ #category : 'enumerating' }
LpElement >> dockChild [

	^ self ancestorDetect: [ :each | each isKindOf: LpDockChild ] ifNone: [ nil ].
]

{ #category : 'instance creation' }
LpElement >> newLabel: aString color: aColor [

	^ BlTextElement new
		text: (self theme text: aString color: aColor);
		yourself
]

{ #category : 'instance creation' }
LpElement >> theme [

	^ LpTheme current
]
