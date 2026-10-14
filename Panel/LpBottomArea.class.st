Class {
	#name : 'LpBottomArea',
	#superclass : 'LpArea',
	#category : 'Panel-Core',
	#package : 'Panel',
	#tag : 'Core'
}

{ #category : 'defaults' }
LpBottomArea >> defaultSizeIn: aTheme [

	^ aTheme defaultSideWidth
]

{ #category : 'accessing' }
LpBottomArea >> handleFirst [

	^ true.
]

{ #category : 'accessing' }
LpBottomArea >> isBottom [

	^ true.
]

{ #category : 'accessing' }
LpBottomArea >> isHorizontal [

	^ false.
]

{ #category : 'accessing' }
LpBottomArea >> name [

	^ #bottom
]

{ #category : 'accessing' }
LpBottomArea >> newToggleIcon [

	^ LpBottomIcon new.
]

{ #category : 'geometry' }
LpBottomArea >> sizeDeltaFor: aPoint [

	^ (self axisValueOf: aPoint) negated.
]
