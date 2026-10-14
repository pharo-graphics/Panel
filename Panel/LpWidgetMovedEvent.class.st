Class {
	#name : 'LpWidgetMovedEvent',
	#superclass : 'LpWidgetEvent',
	#instVars : [
		'fromArea',
		'toArea'
	],
	#category : 'Panel-Events',
	#package : 'Panel',
	#tag : 'Events'
}

{ #category : 'accessing' }
LpWidgetMovedEvent >> fromArea [

	^ fromArea.
]

{ #category : 'accessing' }
LpWidgetMovedEvent >> fromArea: anArea [

	fromArea := anArea.
]

{ #category : 'accessing' }
LpWidgetMovedEvent >> toArea [

	^ toArea.
]

{ #category : 'accessing' }
LpWidgetMovedEvent >> toArea: anArea [

	toArea := anArea.
]
