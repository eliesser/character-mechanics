class_name PlayerStateJumpUp extends PlayerStateGravityBase

func onPhysicsProcess(delta: float) -> void:
	player.velocity.x = Input.get_axis("ui_left", "ui_right") * player.SPEED_RUN
	player.playAnimation(player.animation.jumpUp)
	
	if player.is_on_floor() and player.velocity.y == 0:
		player.velocity.y = player.JUMP_VELOCITY
	elif player.velocity.y > 0:
		player.canDobleJump = true
		stateMachine.changeTo(player.states.jumpTop)
	
	setGravity(delta)
	
	player.move_and_slide()

func onInput(_event) -> void:
	if Input.is_action_pressed("jump"):
		player.velocity.y = player.DOBLE_JUMP_VELOCITY
		player.canDobleJump = false
		stateMachine.changeTo(player.states.airSpin)
