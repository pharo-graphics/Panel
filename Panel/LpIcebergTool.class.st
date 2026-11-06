Class {
	#name : 'LpIcebergTool',
	#superclass : 'LpTool',
	#category : 'Panel-Tools',
	#package : 'Panel',
	#tag : 'Tools'
}

{ #category : 'instance creation' }
LpIcebergTool class >> isAvailable [

	^ Smalltalk globals includesKey: #IceTipRepositoriesBrowser.
]

{ #category : 'instance creation' }
LpIcebergTool class >> label [

	^ 'Git repositories'.
]

{ #category : 'instance creation' }
LpIcebergTool class >> newContent [

	| ele |
	ele := (Smalltalk globals at: #IceTipRepositoriesBrowser ifAbsent: [ ^ LpMorphElement morph: nil ]) new build.
	^ LpMorphElement morph: ele.
]
