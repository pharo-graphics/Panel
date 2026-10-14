Class {
	#name : 'LpAreaToggleButton',
	#superclass : 'LpIconButton',
	#instVars : [
		'area',
		'dock'
	],
	#category : 'Panel-Elements',
	#package : 'Panel',
	#tag : 'Elements'
}

{ #category : 'initialization' }
LpAreaToggleButton class >> area: anArea dock: aDock [

	^ self new
		area: anArea dock: aDock;
		yourself.
]

{ #category : 'accessing' }
LpAreaToggleButton >> area [

	^ area
]

{ #category : 'accessing' }
LpAreaToggleButton >> area: anObject [

	area := anObject
]

{ #category : 'updating' }
LpAreaToggleButton >> area: anArea dock: aDock [

	area := anArea.
	dock := aDock.
	self icon: anArea newToggleIcon.
	self action: [ dock toggleArea: area ].
	self updateState.
]

{ #category : 'accessing' }
LpAreaToggleButton >> dock [

	^ dock
]

{ #category : 'accessing' }
LpAreaToggleButton >> dock: anObject [

	dock := anObject
]

{ #category : 'updating' }
LpAreaToggleButton >> updateState [

	self icon active: (dock isRevealed: area).
]
