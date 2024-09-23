class_name PlayerStateWalkCrouch extends PlayerStateGravityBase
	
func onPhysicsProcess(delta: float) -> void:
	player.velocity.x = Input.get_axis("ui_left", "ui_right") * (player.SPEED_WALL - 50)
	player.playAnimation(player.animation.walkCrouch)
	
	setGravity(delta)
	
	player.move_and_slide()

func onInput(_event) -> void:
	if Input.is_action_pressed("jump"):
		stateMachine.changeTo(player.states.jumpUp)
	elif not Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		stateMachine.changeTo(player.states.idleCrouch)
	elif not Input.is_action_pressed("ui_down"):
		stateMachine.changeTo(player.states.idle)
