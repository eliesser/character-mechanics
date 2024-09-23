class_name PlayerStateWallSlide extends PlayerStateGravityBase

@export var rayCastStuckOnWall: RayCastStuckOnWall

func onPhysicsProcess(delta: float) -> void:
	if rayCastStuckOnWall.is_colliding():
		if rayCastStuckOnWall.get_collider().is_in_group("groupWallLand"):
			stateMachine.changeTo(player.states.wallLand)
		elif rayCastStuckOnWall.get_collider().is_in_group("groupClimbLedge"):
			stateMachine.changeTo(player.states.wallLand)
		elif player.is_on_floor():
			stateMachine.changeTo(player.states.land)
			player.gravity = player.GRAVITY
		else:
			player.playAnimation(player.animation.wallSlide)
			player.gravity = 1
	elif player.is_on_floor():
		stateMachine.changeTo(player.states.land)
		player.gravity = player.GRAVITY
	
	setGravity(delta)
	
	player.move_and_slide()
