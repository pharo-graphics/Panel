Class {
	#name : 'LpTheme',
	#superclass : 'Object',
	#instVars : [
		'windowBackground',
		'panelBackground',
		'headerBackground',
		'accentColor',
		'borderColor',
		'handleColor',
		'handleHoverColor',
		'handleActiveColor',
		'textColor',
		'placeholderColor',
		'iconColor',
		'iconActiveColor',
		'buttonHoverBackground',
		'menuBackground',
		'menuHoverBackground',
		'railColor',
		'railHoverColor',
		'editorBackground',
		'dropZoneColor',
		'dropZoneHoverColor',
		'ghostBackground',
		'fontSize',
		'headerHeight',
		'headerBarHeight',
		'handleThickness',
		'panelMinimumSize',
		'centerMinimumSize',
		'defaultSideWidth',
		'defaultRailHeight',
		'railThickness',
		'dropZoneSize',
		'toolbarButtonSize',
		'menuWidth',
		'menuItemHeight'
	],
	#classVars : [
		'Current'
	],
	#category : 'Panel-Core',
	#package : 'Panel',
	#tag : 'Core'
}

{ #category : 'accessing' }
LpTheme class >> current [

	^ Current ifNil: [ Current := self dark ].
]

{ #category : 'accessing' }
LpTheme class >> current: aTheme [

	Current := aTheme
]

{ #category : 'api - text weight' }
LpTheme class >> dark [

	^ self new
]

{ #category : 'as yet unclassified' }
LpTheme class >> exampleDock [

	<script>
	| dock space |
	LpTheme reset.

	space := BlSpace new
		extent: 1200 @ 800;
		useMorphicHost;
		yourself.

	dock := LpDock new.
	dock beMatchParent.

	space root addChild: dock.
	space show.
	^ space
]

{ #category : 'as yet unclassified' }
LpTheme class >> examplePanel_1000x600 [

	<script>
	| dock space |
	LpTheme reset.

	space := BlSpace new
		extent: 1000 @ 600;
		useMorphicHost;
		yourself.

	dock := LpDock new.
	dock beMatchParent.

	space root addChild: dock.
	space show.
	^ space
]

{ #category : 'as yet unclassified' }
LpTheme class >> examplePanel_1000x650 [

	<script>
	| dock space |
	LpTheme reset.

	space := BlSpace new
		extent: 1000 @ 600;
		useMorphicHost;
		yourself.

	dock := LpDock new.
	dock beMatchParent.

	space root addChild: dock.
	space show.
	^ space
]

{ #category : 'api - text weight' }
LpTheme class >> light [

	^ self new
		beLight;
		yourself.
]

{ #category : 'initialization' }
LpTheme class >> reset [

	Current := nil
]

{ #category : 'accessing' }
LpTheme >> accentColor [

	^ accentColor
]

{ #category : 'accessing' }
LpTheme >> accentColor: anObject [

	accentColor := anObject
]

{ #category : 'initialization' }
LpTheme >> beLight [

	windowBackground := Color fromHexString: 'F6F5F4'.
	panelBackground := Color fromHexString: 'EBEBEB'.
	headerBackground := Color fromHexString: 'E1E1E1'.
	accentColor := Color fromHexString: '3584E4'.
	borderColor := Color fromHexString: 'C8C8C8'.
	handleColor := Color fromHexString: 'D5D5D5'.
	handleHoverColor := Color fromHexString: '3584E4'.
	handleActiveColor := Color fromHexString: '1C71D8'.
	textColor := Color fromHexString: '1A1A1A'.
	placeholderColor := Color fromHexString: '8A8A8A'.
	iconColor := Color fromHexString: '5E5E5E'.
	iconActiveColor := Color fromHexString: '1A1A1A'.
	buttonHoverBackground := Color fromHexString: 'D6D6D6'.
	menuBackground := Color fromHexString: 'FFFFFF'.
	menuHoverBackground := Color fromHexString: 'E8E8E8'.
	railColor := Color fromHexString: 'D0D0D0'.
	railHoverColor := Color fromHexString: '3584E4'.
	editorBackground := Color fromHexString: 'FAFAFA'.
	dropZoneColor := nil.
	dropZoneHoverColor := nil.
	ghostBackground := nil.
]

{ #category : 'accessing' }
LpTheme >> borderColor [

	^ borderColor
]

{ #category : 'accessing' }
LpTheme >> borderColor: anObject [

	borderColor := anObject
]

{ #category : 'accessing' }
LpTheme >> buttonHoverBackground [

	^ buttonHoverBackground
]

{ #category : 'accessing' }
LpTheme >> buttonHoverBackground: anObject [

	buttonHoverBackground := anObject
]

{ #category : 'accessing' }
LpTheme >> centerMinimumSize [

	^ centerMinimumSize
]

{ #category : 'accessing' }
LpTheme >> centerMinimumSize: anObject [

	centerMinimumSize := anObject
]

{ #category : 'accessing' }
LpTheme >> defaultRailHeight [

	^ defaultRailHeight
]

{ #category : 'accessing' }
LpTheme >> defaultRailHeight: anObject [

	defaultRailHeight := anObject
]

{ #category : 'accessing' }
LpTheme >> defaultSideWidth [

	^ defaultSideWidth
]

{ #category : 'accessing' }
LpTheme >> defaultSideWidth: anObject [

	defaultSideWidth := anObject
]

{ #category : 'initialization' }
LpTheme >> dropZoneColor [

	^ dropZoneColor ifNil: [ accentColor alpha: 0.18 ].
]

{ #category : 'accessing' }
LpTheme >> dropZoneColor: anObject [

	dropZoneColor := anObject
]

{ #category : 'initialization' }
LpTheme >> dropZoneHoverColor [

	^ dropZoneHoverColor ifNil: [ accentColor alpha: 0.42 ].
]

{ #category : 'accessing' }
LpTheme >> dropZoneHoverColor: anObject [

	dropZoneHoverColor := anObject
]

{ #category : 'accessing' }
LpTheme >> dropZoneSize [

	^ dropZoneSize
]

{ #category : 'accessing' }
LpTheme >> dropZoneSize: anObject [

	dropZoneSize := anObject
]

{ #category : 'accessing' }
LpTheme >> editorBackground [

	^ editorBackground
]

{ #category : 'accessing' }
LpTheme >> editorBackground: anObject [

	editorBackground := anObject
]

{ #category : 'accessing' }
LpTheme >> fontSize [

	^ fontSize
]

{ #category : 'accessing' }
LpTheme >> fontSize: anObject [

	fontSize := anObject
]

{ #category : 'initialization' }
LpTheme >> ghostBackground [

	^ ghostBackground ifNil: [ accentColor alpha: 0.65 ].
]

{ #category : 'accessing' }
LpTheme >> ghostBackground: anObject [

	ghostBackground := anObject
]

{ #category : 'accessing' }
LpTheme >> handleActiveColor [

	^ handleActiveColor
]

{ #category : 'accessing' }
LpTheme >> handleActiveColor: anObject [

	handleActiveColor := anObject
]

{ #category : 'accessing' }
LpTheme >> handleColor [

	^ handleColor
]

{ #category : 'accessing' }
LpTheme >> handleColor: anObject [

	handleColor := anObject
]

{ #category : 'accessing' }
LpTheme >> handleHoverColor [

	^ handleHoverColor
]

{ #category : 'accessing' }
LpTheme >> handleHoverColor: anObject [

	handleHoverColor := anObject
]

{ #category : 'accessing' }
LpTheme >> handleThickness [

	^ handleThickness
]

{ #category : 'accessing' }
LpTheme >> handleThickness: anObject [

	handleThickness := anObject
]

{ #category : 'accessing' }
LpTheme >> headerBackground [

	^ headerBackground
]

{ #category : 'accessing' }
LpTheme >> headerBackground: anObject [

	headerBackground := anObject
]

{ #category : 'accessing' }
LpTheme >> headerBarHeight [

	^ headerBarHeight
]

{ #category : 'accessing' }
LpTheme >> headerBarHeight: anObject [

	headerBarHeight := anObject
]

{ #category : 'accessing' }
LpTheme >> headerHeight [

	^ headerHeight
]

{ #category : 'accessing' }
LpTheme >> headerHeight: anObject [

	headerHeight := anObject
]

{ #category : 'accessing' }
LpTheme >> iconActiveColor [

	^ iconActiveColor
]

{ #category : 'accessing' }
LpTheme >> iconActiveColor: anObject [

	iconActiveColor := anObject
]

{ #category : 'accessing' }
LpTheme >> iconColor [

	^ iconColor
]

{ #category : 'accessing' }
LpTheme >> iconColor: anObject [

	iconColor := anObject
]

{ #category : 'initialization' }
LpTheme >> initialize [

	super initialize.
	windowBackground := Color fromHexString: '1E1E1E'.
	panelBackground := Color fromHexString: '242424'.
	headerBackground := Color fromHexString: '1B1B1B'.
	accentColor := Color fromHexString: '3584E4'.
	borderColor := Color fromHexString: '3A3A3A'.
	handleColor := Color fromHexString: '161616'.
	handleHoverColor := Color fromHexString: '3584E4'.
	handleActiveColor := Color fromHexString: '62A0EA'.
	textColor := Color fromHexString: 'E6E6E6'.
	placeholderColor := Color fromHexString: '6E6E6E'.
	iconColor := Color fromHexString: 'A0A0A0'.
	iconActiveColor := Color fromHexString: 'E6E6E6'.
	buttonHoverBackground := Color fromHexString: '2E2E2E'.
	menuBackground := Color fromHexString: '2B2B2B'.
	menuHoverBackground := Color fromHexString: '3A3A3A'.
	railColor := Color fromHexString: '2E2E2E'.
	railHoverColor := Color fromHexString: '3584E4'.
	editorBackground := Color fromHexString: '1E1E1E'.
	fontSize := 12.
	headerHeight := 30.
	headerBarHeight := 36.
	handleThickness := 6.
	panelMinimumSize := 48.
	centerMinimumSize := 96.
	defaultSideWidth := 200.
	defaultRailHeight := 180.
	railThickness := 10.
	dropZoneSize := 96.
	toolbarButtonSize := 26.
	menuWidth := 220.
	menuItemHeight := 28
]

{ #category : 'accessing' }
LpTheme >> menuBackground [

	^ menuBackground
]

{ #category : 'accessing' }
LpTheme >> menuBackground: anObject [

	menuBackground := anObject
]

{ #category : 'accessing' }
LpTheme >> menuHoverBackground [

	^ menuHoverBackground
]

{ #category : 'accessing' }
LpTheme >> menuHoverBackground: anObject [

	menuHoverBackground := anObject
]

{ #category : 'accessing' }
LpTheme >> menuItemHeight [

	^ menuItemHeight
]

{ #category : 'accessing' }
LpTheme >> menuItemHeight: anObject [

	menuItemHeight := anObject
]

{ #category : 'accessing' }
LpTheme >> menuWidth [

	^ menuWidth
]

{ #category : 'accessing' }
LpTheme >> menuWidth: anObject [

	menuWidth := anObject
]

{ #category : 'accessing' }
LpTheme >> panelBackground [

	^ panelBackground
]

{ #category : 'accessing' }
LpTheme >> panelBackground: anObject [

	panelBackground := anObject
]

{ #category : 'accessing' }
LpTheme >> panelMinimumSize [

	^ panelMinimumSize
]

{ #category : 'accessing' }
LpTheme >> panelMinimumSize: anObject [

	panelMinimumSize := anObject
]

{ #category : 'accessing' }
LpTheme >> placeholderColor [

	^ placeholderColor
]

{ #category : 'accessing' }
LpTheme >> placeholderColor: anObject [

	placeholderColor := anObject
]

{ #category : 'accessing' }
LpTheme >> railColor [

	^ railColor
]

{ #category : 'accessing' }
LpTheme >> railColor: anObject [

	railColor := anObject
]

{ #category : 'accessing' }
LpTheme >> railHoverColor [

	^ railHoverColor
]

{ #category : 'accessing' }
LpTheme >> railHoverColor: anObject [

	railHoverColor := anObject
]

{ #category : 'accessing' }
LpTheme >> railThickness [

	^ railThickness
]

{ #category : 'accessing' }
LpTheme >> railThickness: anObject [

	railThickness := anObject
]

{ #category : 'text style' }
LpTheme >> text: aString color: aColor [

	^ aString asRopedText
		fontSize: fontSize;
		foreground: aColor;
		yourself
]

{ #category : 'accessing' }
LpTheme >> textColor [

	^ textColor
]

{ #category : 'accessing' }
LpTheme >> textColor: anObject [

	textColor := anObject
]

{ #category : 'accessing' }
LpTheme >> toolbarButtonSize [

	^ toolbarButtonSize
]

{ #category : 'accessing' }
LpTheme >> toolbarButtonSize: anObject [

	toolbarButtonSize := anObject
]

{ #category : 'accessing' }
LpTheme >> windowBackground [

	^ windowBackground
]

{ #category : 'accessing' }
LpTheme >> windowBackground: anObject [

	windowBackground := anObject
]
