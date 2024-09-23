class_name PlayerStateGravityBase extends PlayerStateBase

func start():
	player = controllerNode

func setGravity(delta):
	player.velocity.y += player.gravity * delta
