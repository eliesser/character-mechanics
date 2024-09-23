class_name PlayerStateWalk extends StateBase

var player: Player

func start():
	player = controllerNode
	
func onPhysicsProcess(delta: float) -> void:
	player.velocity.x = Input.get_axis("ui_left", "ui_right") * player.SPEED_WALL
	player.playAnimation('walk')
	
	setGravity(delta)
	
	player.move_and_slide()

func setGravity(delta):
	player.velocity.y += player.gravity * delta

func onInput(event) -> void:
	if not Input.is_action_pressed("walkLeft") and not Input.is_action_pressed("walkRight"):
		stateMachine.changeTo(player.states.idle)
