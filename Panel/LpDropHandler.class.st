Class {
	#name : 'LpDropHandler',
	#superclass : 'BlCustomEventHandler',
	#category : 'Panel-Events',
	#package : 'Panel',
	#tag : 'Events'
}

{ #category : 'api - accessing' }
LpDropHandler >> dragEnterEvent: anEvent [

	anEvent currentTarget dragEntered.
]

{ #category : 'api - accessing' }
LpDropHandler >> dragLeaveEvent: anEvent [

	anEvent currentTarget dragLeft.
]

{ #category : 'api - accessing' }
LpDropHandler >> dropEvent: anEvent [

	| dockChild |
	anEvent isConsumed ifTrue: [ ^ self ].
	dockChild := anEvent currentTarget.
	dockChild dock ifNotNil: [ :aDock |
		aDock isDragging ifTrue: [
			anEvent consume.
			aDock dropWidgetOn: dockChild ] ].
]

{ #category : 'api - accessing' }
LpDropHandler >> eventsToHandle [

	^ { BlDragEnterEvent. BlDragLeaveEvent. BlDropEvent }.
]
