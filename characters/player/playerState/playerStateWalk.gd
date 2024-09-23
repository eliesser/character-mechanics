class_name PlayerStateWalk extends PlayerStateGravityBase
	
func onPhysicsProcess(delta: float) -> void:
	player.velocity.x = Input.get_axis("ui_left", "ui_right") * player.SPEED_WALL
	player.playAnimation(player.animation.walk)
	
	if not player.is_on_floor() and player.velocity.y >= 0:
		stateMachine.changeTo(player.states.jumpTop)
	
	setGravity(delta)
	
	player.move_and_slide()

func onInput(_event) -> void:
	if Input.is_action_pressed("jump"):
		stateMachine.changeTo(player.states.jumpUp)
	elif Input.is_action_pressed("ui_down"):
		stateMachine.changeTo(player.states.idleCrouch)
	elif not Input.is_action_pressed("walkLeft") and not Input.is_action_pressed("walkRight"):
		stateMachine.changeTo(player.states.idle)
	elif not Input.is_action_pressed("walkCrouchLeft") and not Input.is_action_pressed("walkCrouchRight"):
		stateMachine.changeTo(player.states.idleCrouch)
