class_name PlayerStateIdleCrouch extends StateBase

var player: Player

func start():
	player = controllerNode
	
func onPhysicsProcess(delta: float) -> void:
	player.velocity.x = 0
	player.playAnimation('idleCrouch')
	
	setGravity(delta)
	
	player.move_and_slide()

func setGravity(delta):
	player.velocity.y += player.gravity * delta

func onInput(_event) -> void:
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
		stateMachine.changeTo(player.states.walkCrouch)
	elif Input.is_action_pressed("jump"):
		stateMachine.changeTo(player.states.jumpUp)
	elif not Input.is_action_pressed("ui_down"):
		stateMachine.changeTo(player.states.idle)
