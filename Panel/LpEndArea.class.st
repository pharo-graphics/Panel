Class {
	#name : 'LpEndArea',
	#superclass : 'LpArea',
	#category : 'Panel-Core',
	#package : 'Panel',
	#tag : 'Core'
}

{ #category : 'defaults' }
LpEndArea >> defaultSizeIn: aTheme [

	^ aTheme defaultSideWidth.
]

{ #category : 'accessing' }
LpEndArea >> handleFirst [

	^ true.
]

{ #category : 'accessing' }
LpEndArea >> isEnd [

	^ true.
]

{ #category : 'accessing' }
LpEndArea >> isHorizontal [

	^ true.
]

{ #category : 'accessing' }
LpEndArea >> name [

	^ #end.
]

{ #category : 'accessing' }
LpEndArea >> newToggleIcon [

	^ LpEndIcon new.
]

{ #category : 'geometry' }
LpEndArea >> sizeDeltaFor: aPoint [

	^ (self axisValueOf: aPoint) negated.
]
