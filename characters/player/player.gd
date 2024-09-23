class_name Player extends CharacterBody2D

@onready var animations = $animations

const JUMP_VELOCITY:int = -500
const DOBLE_JUMP_VELOCITY:int = -400
const SPEED_RUN:int = 300
const SPEED_WALL:int = 150
const GRAVITY = 980

var gravity = GRAVITY
var canDobleJump:bool = false
var states:PlayerStatesNames = PlayerStatesNames.new()

func _process(_delta: float) -> void:
	setFlip(velocity.x)

func setFlip(x:float) -> void:
	if abs(x) > 0:
		$animations.scale.x = -1 if x < 0 else 1

func isFlip() -> bool:
	return $animations.scale.x < 0

func playAnimation(animation:String) -> void:
	animations.play(animation)
