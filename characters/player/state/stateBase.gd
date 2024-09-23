class_name StateBase extends Node

@onready var controllerNode:Node = self.owner

var stateMachine: StateMachine

func start():
	pass

func end():
	pass

func onAnimationFinish(_animationName:String):
	pass
