Class {
	#name : 'LpStartArea',
	#superclass : 'LpArea',
	#category : 'Panel-Core',
	#package : 'Panel',
	#tag : 'Core'
}

{ #category : 'defaults' }
LpStartArea >> defaultSizeIn: aTheme [

	^ aTheme defaultSideWidth.
]

{ #category : 'accessing' }
LpStartArea >> isHorizontal [

	^ true.
]

{ #category : 'accessing' }
LpStartArea >> isStart [

	^ true.
]

{ #category : 'accessing' }
LpStartArea >> name [

	^ #start.
]

{ #category : 'accessing' }
LpStartArea >> newToggleIcon [

	^ LpStartIcon new.
]
