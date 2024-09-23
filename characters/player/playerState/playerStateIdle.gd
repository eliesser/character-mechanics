class_name PlayerStateIdle extends PlayerStateGravityBase
	
func onPhysicsProcess(delta: float) -> void:
	player.velocity.x = 0
	player.playAnimation(player.animation.idle)
	
	setGravity(delta)
	
	player.move_and_slide()

func onInput(_event) -> void:
	if Input.is_action_pressed("walkLeft") or Input.is_action_pressed("walkRight"):
		stateMachine.changeTo(player.states.walk)
	elif Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
		stateMachine.changeTo(player.states.run)
	elif Input.is_action_pressed("jump"):
		stateMachine.changeTo(player.states.jumpUp)
	elif Input.is_action_pressed("ui_down"):
		stateMachine.changeTo(player.states.idleCrouch)
