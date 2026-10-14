Class {
	#name : 'LpToggleIcon',
	#superclass : 'LpElement',
	#instVars : [
		'bar',
		'active'
	],
	#category : 'Panel-Elements',
	#package : 'Panel',
	#tag : 'Elements'
}

{ #category : 'accessing' }
LpToggleIcon >> active [

	^ active
]

{ #category : 'accessing' }
LpToggleIcon >> active: aBoolean [

	active := aBoolean.
	bar background: (aBoolean
		ifTrue: [ self theme iconActiveColor ]
		ifFalse: [ self theme iconColor alpha: 0.35 ]).
]

{ #category : 'accessing' }
LpToggleIcon >> bar [

	^ bar
]

{ #category : 'accessing' }
LpToggleIcon >> bar: anObject [

	bar := anObject
]

{ #category : 'initialization' }
LpToggleIcon >> initialize [

	super initialize.
	active := true.
	self padding: (BlInsets all: 2).
]

{ #category : 'accessing' }
LpToggleIcon >> isActive [

	^ active.
]
