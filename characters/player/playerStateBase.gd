class_name PlayerStateBase extends StateBase

var player:Player:
	set(value):
		controllerNode = player
	get:
		return controllerNode
