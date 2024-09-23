class_name PlayerStateRun extends PlayerStateGravityBase

func onPhysicsProcess(delta: float) -> void:
	player.velocity.x = Input.get_axis("ui_left", "ui_right") * player.SPEED_RUN
	player.playAnimation(player.animation.run)
	
	if not player.is_on_floor() and player.velocity.y >= 0:
		stateMachine.changeTo(player.states.jumpTop)
	
	setGravity(delta)
	
	player.move_and_slide()

func onInput(_event) -> void:
	if Input.is_action_pressed("jump"):
		stateMachine.changeTo(player.states.jumpUp)
	elif Input.is_action_pressed("walkLeft") or Input.is_action_pressed("walkRight"):
		stateMachine.changeTo(player.states.walk)
	elif Input.is_action_pressed("ui_down"):
		stateMachine.changeTo(player.states.idleCrouch)
	if not Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		stateMachine.changeTo(player.states.idle)
