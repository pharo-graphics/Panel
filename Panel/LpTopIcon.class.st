Class {
	#name : 'LpTopIcon',
	#superclass : 'LpToggleIcon',
	#category : 'Panel-Elements',
	#package : 'Panel',
	#tag : 'Elements'
}

{ #category : 'initialization' }
LpTopIcon >> initialize [

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
		c vertical exact: 3.
		c horizontal matchParent.
		c frame vertical alignTop ].
	self addChild: bar.

	self active: true.
]
