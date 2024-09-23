class_name PlayerStateSpin extends StateBase

@export var rayCastStuckOnWall: RayCastStuckOnWall

var player: Player

func start():
	player = controllerNode

func onPhysicsProcess(delta: float) -> void:
	player.velocity.x = Input.get_axis("ui_left", "ui_right") * player.SPEED_RUN
	player.playAnimation('airSpin')
	
	if player.canDobleJump:
		player.velocity.y = player.DOBLE_JUMP_VELOCITY
		player.canDobleJump = false
	
	if player.is_on_floor() and player.velocity.y == 0:
		if player.velocity.x == 0:
			stateMachine.changeTo(player.states.land)
		else:
			stateMachine.changeTo(player.states.run)
	elif rayCastStuckOnWall.is_colliding():
		if rayCastStuckOnWall.get_collider().is_in_group("groupWallLand"):
			stateMachine.changeTo(player.states.land)
		elif rayCastStuckOnWall.get_collider().is_in_group("groupClimbLedge"):
			stateMachine.changeTo(player.states.land)
	
	setGravity(delta)
	
	player.move_and_slide()

func setGravity(delta):
	player.velocity.y += player.gravity * delta
