class_name PlayerStateLand extends PlayerStateGravityBase

func onPhysicsProcess(delta: float) -> void:
	player.velocity.x = 0
	player.playAnimation(player.animation.land)
	
	setGravity(delta)
	
	player.move_and_slide()

func onAnimationFinish(animationName:String) -> void:
	if animationName == 'land':
		stateMachine.changeTo(player.states.idle)
