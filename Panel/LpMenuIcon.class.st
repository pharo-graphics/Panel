Class {
	#name : 'LpMenuIcon',
	#superclass : 'LpElement',
	#category : 'Panel-Elements',
	#package : 'Panel',
	#tag : 'Elements'
}

{ #category : 'initialization' }
LpMenuIcon >> initialize [

	super initialize.
	self layout: (BlLinearLayout vertical cellSpacing: 3).
	self constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].
	3 timesRepeat: [ self addChild: self newDot ].
]

{ #category : 'instance creation' }
LpMenuIcon >> newDot [

	^ BlElement new
		  geometry: BlCircleGeometry new;
		  background: self theme iconActiveColor;
		  constraintsDo: [ :c |
			  c horizontal exact: 3.
			  c vertical exact: 3.
			  c linear weight: 0 ];
		  yourself.
]
