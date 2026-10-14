Class {
	#name : 'LpMenuItem',
	#superclass : 'Object',
	#instVars : [
		'label',
		'action'
	],
	#category : 'Panel-Core',
	#package : 'Panel',
	#tag : 'Core'
}

{ #category : 'initialization' }
LpMenuItem class >> label: aString action: aBlock [

	^ self new
		label: aString;
		action: aBlock;
		yourself.
]

{ #category : 'accessing' }
LpMenuItem >> action [

	^ action.
]

{ #category : 'accessing' }
LpMenuItem >> action: aBlock [

	action := aBlock.
]

{ #category : 'accessing' }
LpMenuItem >> label [

	^ label.
]

{ #category : 'accessing' }
LpMenuItem >> label: aString [

	label := aString.
]

{ #category : 'accessing' }
LpMenuItem >> perform [

	action ifNotNil: [ :aBlock | aBlock value ].
]

{ #category : 'accessing' }
LpMenuItem >> printOn: aStream [

	aStream nextPutAll: 'LpMenuItem('; print: label; nextPut: $).
]
