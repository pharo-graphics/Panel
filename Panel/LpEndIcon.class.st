Class {
	#name : 'LpEndIcon',
	#superclass : 'LpToggleIcon',
	#category : 'Panel-Elements',
	#package : 'Panel',
	#tag : 'Elements'
}

{ #category : 'initialization' }
LpEndIcon >> initialize [

	super initialize.
	self layout: BlFrameLayout new.
	self constraintsDo: [ :c |
		c horizontal exact: 16.
		c vertical exact: 12 ].
	self geometry: (BlRoundedRectangleGeometry cornerRadius: 2).
	self border: (BlBorder paint: self theme iconColor width: 1).
	self outskirts: BlOutskirts inside.

	bar := BlElement new.
	bar constraintsDo: [ :c |
		c horizontal exact: 4.
		c vertical matchParent.
		c frame horizontal alignRight ].
	self addChild: bar.

	self active: true.
]
