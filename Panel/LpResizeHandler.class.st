Class {
	#name : 'LpResizeHandler',
	#superclass : 'BlCustomEventHandler',
	#instVars : [
		'startPosition'
	],
	#category : 'Panel-Events',
	#package : 'Panel',
	#tag : 'Events'
}

{ #category : 'api - accessing' }
LpResizeHandler >> beginOn: aHandle at: aPoint [

	startPosition := aPoint.
	aHandle beActive.
	aHandle resizer beginResize.
]

{ #category : 'api - accessing' }
LpResizeHandler >> clickAbortedEvent: anEvent [

	self endOn: anEvent currentTarget.
]

{ #category : 'api - accessing' }
LpResizeHandler >> dragEndEvent: anEvent [

	anEvent consume.
	self endOn: anEvent currentTarget.
]

{ #category : 'api - accessing' }
LpResizeHandler >> dragEvent: anEvent [

	anEvent consume.
	startPosition ifNil: [ ^ self ].
	anEvent currentTarget resizer resizeBy: anEvent position - startPosition.
]

{ #category : 'api - accessing' }
LpResizeHandler >> dragStartEvent: anEvent [

	anEvent consume.
	startPosition ifNil: [ self beginOn: anEvent currentTarget at: anEvent position ].
]

{ #category : 'api - accessing' }
LpResizeHandler >> endOn: aHandle [

	startPosition ifNil: [ ^ self ].
	startPosition := nil.
	aHandle beNormal.
	aHandle resizer endResize.
]

{ #category : 'api - accessing' }
LpResizeHandler >> eventsToHandle [

	^ {
		BlMouseDownEvent.
		BlMouseUpEvent.
		BlClickAbortedEvent.
		BlDragStartEvent.
		BlDragEvent.
		BlDragEndEvent.
		BlMouseEnterEvent.
		BlMouseLeaveEvent }.
]

{ #category : 'api - accessing' }
LpResizeHandler >> mouseDownEvent: anEvent [

	anEvent primaryButtonPressed ifFalse: [ ^ self ].
	self beginOn: anEvent currentTarget at: anEvent position.
]

{ #category : 'api - accessing' }
LpResizeHandler >> mouseEnterEvent: anEvent [

	anEvent currentTarget beHovered.
]

{ #category : 'api - accessing' }
LpResizeHandler >> mouseLeaveEvent: anEvent [

	anEvent currentTarget isActive ifFalse: [ anEvent currentTarget beNormal ].
]

{ #category : 'api - accessing' }
LpResizeHandler >> mouseUpEvent: anEvent [

	self endOn: anEvent currentTarget.
]

{ #category : 'accessing' }
LpResizeHandler >> startPosition [

	^ startPosition
]

{ #category : 'accessing' }
LpResizeHandler >> startPosition: anObject [

	startPosition := anObject
]
