Class {
	#name : 'LpCenterArea',
	#superclass : 'LpArea',
	#category : 'Panel-Core',
	#package : 'Panel',
	#tag : 'Core'
}

{ #category : 'defaults' }
LpCenterArea >> defaultSizeIn: aTheme [

	^ nil
]

{ #category : 'accessing' }
LpCenterArea >> isCenter [

	^ true.
]

{ #category : 'accessing' }
LpCenterArea >> isHorizontal [

	^ true.
]

{ #category : 'accessing' }
LpCenterArea >> name [

	^ #center
]

{ #category : 'geometry' }
LpCenterArea >> resizeCursor [

	^ Cursor normal.
]

{ #category : 'geometry' }
LpCenterArea >> sizeDeltaFor: aPoint [

	^ 0.
]
