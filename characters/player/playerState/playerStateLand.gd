class_name PlayerStateLand extends PlayerStateGravityBase

func onPhysicsProcess(delta: float) -> void:
	player.velocity.x = Input.get_axis("ui_left", "ui_right") * player.SPEED_WALL
	player.playAnimation(player.animation.land)
	
	setGravity(delta)
	
	player.move_and_slide()

func onAnimationFinish(animationName:String) -> void:
	if animationName == 'land':
		stateMachine.changeTo(player.states.idle)
