class_name Player
extends CharacterBody2D

@onready var animations = $animations

const RAY_CAST_DIMENSION = 7

func _process(_delta: float) -> void:
	setFlip(velocity.x)

func setFlip(x:float) -> void:
	if abs(x) > 0:
		$animations.scale.x = -1 if x < 0 else 1

func isFlip() -> bool:
	return $animations.scale.x < 0

func playAnimation(animation:String) -> void:
	animations.play(animation)
