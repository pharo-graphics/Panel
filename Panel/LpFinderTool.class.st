Class {
	#name : 'LpFinderTool',
	#superclass : 'LpTool',
	#category : 'Panel-Tools',
	#package : 'Panel',
	#tag : 'Tools'
}

{ #category : 'instance creation' }
LpFinderTool class >> isAvailable [

	^ Smalltalk globals includesKey: #StFinderPresenter.
]

{ #category : 'instance creation' }
LpFinderTool class >> label [

	^ 'Finder'.
]

{ #category : 'instance creation' }
LpFinderTool class >> newContent [

	| ele1 ele2 ele |
	ele1 := (Smalltalk globals at: #StFinderModel ifAbsent: [ ^ LpMorphElement morph: nil ]) new.
	ele2 := (Smalltalk globals at: #StFinderPresenter) on: ele1.
	ele1 application: ele2 application.
	ele := ele2 build.
	^ LpMorphElement morph: ele.
]
