Class {
	#name : 'LpTopArea',
	#superclass : 'LpArea',
	#category : 'Panel-Core',
	#package : 'Panel',
	#tag : 'Core'
}

{ #category : 'defaults' }
LpTopArea >> defaultSizeIn: aTheme [

	^ aTheme defaultSideWidth.
]

{ #category : 'accessing' }
LpTopArea >> isHorizontal [

	^ false.
]

{ #category : 'accessing' }
LpTopArea >> isTop [

	^ true.
]

{ #category : 'accessing' }
LpTopArea >> name [

	^ #top.
]

{ #category : 'accessing' }
LpTopArea >> newToggleIcon [

	^ LpTopIcon new.
]
