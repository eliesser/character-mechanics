class_name PlayerStateClimbLedge extends StateBase

var player: Player

func start():
	player = controllerNode

func onPhysicsProcess(delta: float) -> void:
	player.playAnimation('climbLedge')
	player.velocity.y = -110
	
	setGravity(delta)
	
	player.move_and_slide()

func setGravity(delta):
	player.velocity.y += player.gravity * delta
	
func onAnimationFinish(animationName:String) -> void:
	if animationName == 'climbLedge':
		player.velocity.y = 0
		player.velocity.x = 5
		player.gravity = player.GRAVITY
		stateMachine.changeTo(player.states.idle)
