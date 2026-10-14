Class {
	#name : 'LpArea',
	#superclass : 'Object',
	#classVars : [
		'Bottom',
		'Center',
		'End',
		'Start',
		'Top'
	],
	#category : 'Panel-Core',
	#package : 'Panel',
	#tag : 'Core'
}

{ #category : 'accessing' }
LpArea class >> all [

	^ { self start. self end. self top. self bottom. self center }.
]

{ #category : 'accessing' }
LpArea class >> bottom [

	^ Bottom ifNil: [ Bottom := LpBottomArea new ].
]

{ #category : 'accessing' }
LpArea class >> center [

	^ Center ifNil: [ Center := LpCenterArea new ].
]

{ #category : 'accessing' }
LpArea class >> edges [

	"which areas are surrounding center ara"

	^ { self start. self end. self top. self bottom }.
]

{ #category : 'accessing' }
LpArea class >> end [

	^ End ifNil: [ End := LpEndArea new ].
]

{ #category : 'accessing' }
LpArea class >> named: aSymbol [

	^ self all detect: [ :each | each name = aSymbol asSymbol ].
]

{ #category : 'initialization' }
LpArea class >> reset [

	Start := nil.
	    End := nil.
	Top := nil.
	Bottom := nil.
	Center := nil.
]

{ #category : 'accessing' }
LpArea class >> start [

	^ Start ifNil: [ Start := LpStartArea new ].
]

{ #category : 'accessing' }
LpArea class >> top [

	^ Top ifNil: [ Top := LpTopArea new ].
]

{ #category : 'geometry' }
LpArea >> axisValueOf: aPoint [

	"give x/y point on which direction resize is done. so if left to right then x axis should be returned"

	^ self isHorizontal
		ifTrue: [ aPoint x ]
		ifFalse: [ aPoint y ].
]

{ #category : 'defaults' }
LpArea >> defaultSizeIn: aTheme [

	^ self subclassResponsibility.
]

{ #category : 'accessing' }
LpArea >> handleFirst [

	^ false.
]

{ #category : 'testing' }
LpArea >> isBottom [

	^ false.
]

{ #category : 'accessing' }
LpArea >> isCenter [

	^ false.
]

{ #category : 'accessing' }
LpArea >> isEdge [

	^ self isCenter not.
]

{ #category : 'testing' }
LpArea >> isEnd [

	^ false.
]

{ #category : 'accessing' }
LpArea >> isHorizontal [

	^ self subclassResponsibility.
]

{ #category : 'testing' }
LpArea >> isStart [

	^ false.
]

{ #category : 'testing' }
LpArea >> isTop [

	^ false.
]

{ #category : 'accessing' }
LpArea >> isVertical [

	^ self isHorizontal not.
]

{ #category : 'accessing' }
LpArea >> name [

	^ self subclassResponsibility.
]

{ #category : 'instance creation' }
LpArea >> newResizerLayout [

	^ self isHorizontal
		ifTrue: [ BlLinearLayout horizontal ]
		ifFalse: [ BlLinearLayout vertical ].
]

{ #category : 'accessing' }
LpArea >> newToggleIcon [

	^ self subclassResponsibility.
]

{ #category : 'printing' }
LpArea >> printOn: aStream [

	aStream
		nextPutAll: 'LpArea ';
		nextPutAll: self name.
]

{ #category : 'geometry' }
LpArea >> resizeCursor [

	"for changing mouse cursor"

	^ self isHorizontal
		ifTrue: [ Cursor resizeLeft ]
		ifFalse: [ Cursor resizeTop ].
]

{ #category : 'geometry' }
LpArea >> sizeDeltaFor: aPoint [

	^ self axisValueOf: aPoint.
]
