Class {
	#name : 'LpPlaygroundTool',
	#superclass : 'LpTool',
	#category : 'Panel-Tools',
	#package : 'Panel',
	#tag : 'Tools'
}

{ #category : 'instance creation' }
LpPlaygroundTool class >> isAvailable [

	^ Smalltalk globals includesKey: #StPlaygroundPresenter.
]

{ #category : 'instance creation' }
LpPlaygroundTool class >> label [

	^ 'Playground'.
]

{ #category : 'instance creation' }
LpPlaygroundTool class >> newContent [

	| ele |
	ele := (Smalltalk globals at: #StPlaygroundPresenter ifAbsent: [ ^ LpMorphElement morph: nil ]) new build.
	^ LpMorphElement morph: ele.
]
