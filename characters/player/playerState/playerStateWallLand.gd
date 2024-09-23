class_name PlayerStateWallLand extends StateBase

@export var rayCastStuckOnWall: RayCastStuckOnWall
@export var timerRayCastStuckOnWall: Timer

var player: Player

func start():
	player = controllerNode
	
func onPhysicsProcess(delta: float) -> void:
	if player.gravity > 0:
		player.playAnimation('wallLand')
		player.gravity = 0
		player.velocity.y = 0
	
	setGravity(delta)
	
	player.move_and_slide()

func setGravity(delta):
	player.velocity.y += player.gravity * delta

func onInput(event) -> void:
	if Input.is_action_pressed("jump"):
		rayCastStuckOnWall.RAY_CAST_DIMENSION = 0
		player.gravity = player.GRAVITY
		timerRayCastStuckOnWall.start()
		player.canDobleJump = false
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
