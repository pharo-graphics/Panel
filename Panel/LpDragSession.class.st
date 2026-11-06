Class {
	#name : 'LpDragSession',
	#superclass : 'Object',
	#instVars : [
		'widget',
		'sourceTab',
		'ghost',
		'hoveredChild',
		'sourceArea',
		'insertionChild',
		'insertionIndex',
		'insertionMarker'
	],
	#category : 'Panel-Core',
	#package : 'Panel',
	#tag : 'Core'
}

{ #category : 'initialization' }
LpDragSession class >> widget: aWidget sourceTab: aTab [

	^ self new
		widget: aWidget;
		sourceTab: aTab;
		yourself.
]

{ #category : 'accessing' }
LpDragSession >> ghost [

	^ ghost.
]

{ #category : 'accessing' }
LpDragSession >> ghost: anElement [

	ghost := anElement.

]

{ #category : 'accessing' }
LpDragSession >> hoveredChild [

	^ hoveredChild.
]

{ #category : 'accessing' }
LpDragSession >> hoveredChild: aChild [

	hoveredChild := aChild.
]

{ #category : 'accessing' }
LpDragSession >> insertionChild [

	^ insertionChild
]

{ #category : 'accessing' }
LpDragSession >> insertionChild: anObject [

	insertionChild := anObject
]

{ #category : 'accessing' }
LpDragSession >> insertionIndex [

	^ insertionIndex
]

{ #category : 'accessing' }
LpDragSession >> insertionIndex: anObject [

	insertionIndex := anObject
]

{ #category : 'accessing' }
LpDragSession >> insertionIndexFor: aDockChild [

	^ insertionChild == aDockChild
		  ifTrue: [ insertionIndex ]
		  ifFalse: [ nil ].
]

{ #category : 'accessing' }
LpDragSession >> insertionMarker [

	^ insertionMarker
]

{ #category : 'accessing' }
LpDragSession >> insertionMarker: anObject [

	insertionMarker := anObject
]

{ #category : 'accessing' }
LpDragSession >> isHovering: aDockChild [

	^ hoveredChild == aDockChild.

]

{ #category : 'accessing' }
LpDragSession >> sourceArea [

	^ sourceArea.
]

{ #category : 'accessing' }
LpDragSession >> sourceArea: anArea [

	sourceArea := anArea.
]

{ #category : 'accessing' }
LpDragSession >> sourceTab [

	^ sourceTab.
]

{ #category : 'accessing' }
LpDragSession >> sourceTab: aTab [

	sourceTab := aTab.
]

{ #category : 'accessing' }
LpDragSession >> widget [

	^ widget.
]

{ #category : 'accessing' }
LpDragSession >> widget: aWidget [

	widget := aWidget.
	sourceArea := aWidget dockChild ifNotNil: [ :aDockChild | aDockChild area ].

]
