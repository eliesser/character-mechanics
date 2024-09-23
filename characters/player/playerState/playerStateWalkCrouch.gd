class_name PlayerStateWalkCrouch extends StateBase

var player: Player

func start():
	player = controllerNode
	
func onPhysicsProcess(delta: float) -> void:
	player.velocity.x = Input.get_axis("ui_left", "ui_right") * (player.SPEED_WALL - 50)
	player.playAnimation('walkCrouch')
	
	setGravity(delta)
	
	player.move_and_slide()

func setGravity(delta):
	player.velocity.y += player.gravity * delta

func onInput(event) -> void:
	if Input.is_action_pressed("jump"):
		stateMachine.changeTo(player.states.jumpUp)
	elif not Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		stateMachine.changeTo(player.states.idleCrouch)
	elif not Input.is_action_pressed("ui_down"):
		stateMachine.changeTo(player.states.idle)
