class_name PlayerStateSpin extends PlayerStateGravityBase

@export var rayCastStuckOnWall: RayCastStuckOnWall

func onPhysicsProcess(delta: float) -> void:
	player.velocity.x = Input.get_axis("ui_left", "ui_right") * player.SPEED_RUN
	
	if player.countJump == 1:
		player.playAnimation(player.animation.airSpin)
		player.velocity.y = player.DOBLE_JUMP_VELOCITY
		player.countJump += 1
	
	if player.is_on_floor() and player.velocity.y == 0:
		if player.velocity.x != 0:
			stateMachine.changeTo(player.states.run)
		else:
			stateMachine.changeTo(player.states.idle)
	elif rayCastStuckOnWall.is_colliding():
		if rayCastStuckOnWall.get_collider().is_in_group("groupWallLand"):
			stateMachine.changeTo(player.states.wallLand)
		elif rayCastStuckOnWall.get_collider().is_in_group("groupClimbLedge"):
			stateMachine.changeTo(player.states.wallLand)
		else:
			stateMachine.changeTo(player.states.wallSlide)
	
	setGravity(delta)
	
	player.move_and_slide()
