class_name PlayerStateClimbLedge extends PlayerStateGravityBase

func onPhysicsProcess(delta: float) -> void:
	player.playAnimation(player.animation.climbLedge)
	player.velocity.y = -110
	
	setGravity(delta)
	
	player.move_and_slide()
	
func onAnimationFinish(animationName:String) -> void:
	if animationName == 'climbLedge':
		player.velocity.y = 0
		player.velocity.x = 5
		player.gravity = player.GRAVITY
		stateMachine.changeTo(player.states.idle)
