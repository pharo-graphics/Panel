Class {
	#name : 'BaselineOfPanel',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfPanel',
	#package : 'BaselineOfPanel'
}

{ #category : 'baselines' }
BaselineOfPanel >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec
			baseline: 'Bloc'
			with: [ spec repository: 'github://pharo-graphics/Bloc:v2.7.0/src' ].

		spec
			package: 'Panel' with: [ spec requires: #( 'Bloc' ) ].

		spec
			group: 'core' with: #( 'Panel' );
			group: 'default' with: #( 'core' ) ]
]
