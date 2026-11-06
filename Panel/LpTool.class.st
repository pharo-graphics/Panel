Class {
	#name : 'LpTool',
	#superclass : 'Object',
	#category : 'Panel-Tools',
	#package : 'Panel',
	#tag : 'Tools'
}

{ #category : 'instance creation' }
LpTool class >> all [

	^ { LpPlaygroundTool. LpFinderTool. LpIcebergTool } select: [ :each | each isAvailable ].
]

{ #category : 'accessing' }
LpTool class >> isAvailable [

	^ true.
]

{ #category : 'accessing' }
LpTool class >> label [

	^ self subclassResponsibility.
]

{ #category : 'accessing' }
LpTool class >> menuItemFor: aDock [

	^ LpMenuItem label: '+ New ' , self label action: [ aDock open: self in: LpArea bottom ].
]

{ #category : 'instance creation' }
LpTool class >> newContent [

	^ self subclassResponsibility.
]
