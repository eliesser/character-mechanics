class_name PlayerStateGravityBase extends StateBase

var player: Player

func start():
	player = controllerNode

func setGravity(delta):
	player.velocity.y += player.gravity * delta
