class_name PlayerStateLand extends StateBase

var player: Player

func start():
	player = controllerNode

func onPhysicsProcess(delta: float) -> void:
	player.velocity.x = 0
	player.playAnimation('land')
	
	setGravity(delta)
	
	player.move_and_slide()

func setGravity(delta):
	player.velocity.y += player.gravity * delta

func onAnimationFinish(animationName:String) -> void:
	if animationName == 'land':
		stateMachine.changeTo(player.states.idle)
