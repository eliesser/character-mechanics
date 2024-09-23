class_name PlayerStateJumpUp extends StateBase

var player: Player

func start():
	player = controllerNode

func onPhysicsProcess(delta: float) -> void:
	player.velocity.x = Input.get_axis("ui_left", "ui_right") * player.SPEED_RUN
	player.playAnimation('jumpUp')
	
	if player.is_on_floor() and player.velocity.y == 0:
		player.velocity.y = player.JUMP_VELOCITY
	elif player.velocity.y > 0:
		player.canDobleJump = true
		stateMachine.changeTo(player.states.jumpTop)
	
	setGravity(delta)
	
	player.move_and_slide()

func setGravity(delta):
	player.velocity.y += player.gravity * delta
