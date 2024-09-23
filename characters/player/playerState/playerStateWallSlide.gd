class_name PlayerStateWallSlide extends StateBase

@export var rayCastStuckOnWall: RayCastStuckOnWall

var player: Player

func start():
	player = controllerNode

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
			player.playAnimation('wallSlide')
			player.gravity = 1
	
	setGravity(delta)
	
	player.move_and_slide()

func setGravity(delta):
	player.velocity.y += player.gravity * delta
