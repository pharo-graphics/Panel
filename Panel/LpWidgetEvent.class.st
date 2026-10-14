Class {
	#name : 'LpWidgetEvent',
	#superclass : 'LpEvent',
	#instVars : [
		'widget'
	],
	#category : 'Panel-Events',
	#package : 'Panel',
	#tag : 'Events'
}

{ #category : 'accessing' }
LpWidgetEvent >> widget [

	^ widget.
]

{ #category : 'accessing' }
LpWidgetEvent >> widget: aWidget [

	widget := aWidget.
]
