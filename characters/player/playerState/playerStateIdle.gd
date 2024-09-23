class_name PlayerStateIdle extends StateBase

var player: Player

func start():
	player = controllerNode
	
func onPhysicsProcess(delta: float) -> void:
	player.velocity.x = 0
	player.playAnimation('idle')
	
	setGravity(delta)
	
	player.move_and_slide()

func setGravity(delta):
	player.velocity.y += player.gravity * delta

func onInput(_event) -> void:
	if Input.is_action_pressed("walkLeft") or Input.is_action_pressed("walkRight"):
		stateMachine.changeTo(player.states.walk)
	elif Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
		stateMachine.changeTo(player.states.run)
	elif Input.is_action_pressed("jump"):
		stateMachine.changeTo(player.states.jumpUp)
	elif Input.is_action_pressed("ui_down"):
		stateMachine.changeTo(player.states.idleCrouch)
