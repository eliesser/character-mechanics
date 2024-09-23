class_name PlayerStateDown extends StateBase

@export var rayCastStuckOnWall: RayCastStuckOnWall

var player: Player

func start():
	player = controllerNode

func onPhysicsProcess(delta: float) -> void:
	player.velocity.x = Input.get_axis("ui_left", "ui_right") * player.SPEED_RUN
	player.playAnimation('jumpDown')
	
	if player.is_on_floor() and player.velocity.y == 0:
		if player.velocity.x == 0:
			stateMachine.changeTo(player.states.land)
		else:
			stateMachine.changeTo(player.states.run)
	
	setGravity(delta)
	
	player.move_and_slide()

func setGravity(delta):
	player.velocity.y += player.gravity * delta

func onInput(_event) -> void:
	if not player.is_on_floor() and Input.is_action_pressed("jump") and player.canDobleJump:
		stateMachine.changeTo(player.states.airSpin)
	elif rayCastStuckOnWall.is_colliding():
		if rayCastStuckOnWall.get_collider().is_in_group("groupWallLand"):
			stateMachine.changeTo(player.states.wallLand)
		elif rayCastStuckOnWall.get_collider().is_in_group("groupClimbLedge"):
			stateMachine.changeTo(player.states.wallLand)
		else:
			stateMachine.changeTo(player.states.wallSlide)
