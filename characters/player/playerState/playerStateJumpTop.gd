class_name PlayerStateTop extends PlayerStateGravityBase

func onPhysicsProcess(delta: float) -> void:
	player.velocity.x = Input.get_axis("ui_left", "ui_right") * player.SPEED_RUN
	player.playAnimation(player.animation.jumpTop)
	
	setGravity(delta)
	
	player.move_and_slide()

func onInput(_event) -> void:
	if not player.is_on_floor() and Input.is_action_pressed("jump") and player.countJump == 1:
		stateMachine.changeTo(player.states.airSpin)

func onAnimationFinish(animationName:String) -> void:
	if animationName == 'jumpTop':
		stateMachine.changeTo(player.states.jumpDown)
