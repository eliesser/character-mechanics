class_name RayCastStuckOnWall
extends RayCast2D

@onready var player:Player = self.owner

@export var RAY_CAST_DIMENSION = 7

func _ready() -> void:
	self.target_position.x = RAY_CAST_DIMENSION

func _process(_delta: float) -> void:
	if player.isFlip():
		self.target_position.x = -RAY_CAST_DIMENSION
	else:
		self.target_position.x = RAY_CAST_DIMENSION
