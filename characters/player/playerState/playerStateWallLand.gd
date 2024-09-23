class_name PlayerStateWallLand extends PlayerStateGravityBase

@export var rayCastStuckOnWall: RayCastStuckOnWall
@export var timerRayCastStuckOnWall: Timer
	
func onPhysicsProcess(delta: float) -> void:
	if player.gravity > 0:
		player.playAnimation(player.animation.wallLand)
		player.gravity = 0
		player.velocity.y = 0
		player.countJump = 0
	
	setGravity(delta)
	
	player.move_and_slide()

func onInput(_event) -> void:
	if Input.is_action_pressed("jump"):
		rayCastStuckOnWall.RAY_CAST_DIMENSION = 0
		player.gravity = player.GRAVITY
		timerRayCastStuckOnWall.start()
		player.velocity.y = player.JUMP_VELOCITY
		stateMachine.changeTo(player.states.jumpUp)
	elif Input.is_action_pressed("ui_down"):
		rayCastStuckOnWall.RAY_CAST_DIMENSION = 0
		player.gravity = player.GRAVITY
		timerRayCastStuckOnWall.start()
		stateMachine.changeTo(player.states.jumpDown)
	#elif Input.is_action_pressed("ui_up"):
		#rayCastStuckOnWall.RAY_CAST_DIMENSION = 0
		#stateMachine.changeTo(player.states.climbLedge)

func _on_timer_ray_cast_stuck_on_wall_timeout() -> void:
	rayCastStuckOnWall.RAY_CAST_DIMENSION = 7
