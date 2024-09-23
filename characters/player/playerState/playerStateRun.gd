class_name PlayerStateRun extends StateBase

var player: Player

func start():
	player = controllerNode

func onPhysicsProcess(delta: float) -> void:
	player.velocity.x = Input.get_axis("ui_left", "ui_right") * player.SPEED_RUN
	player.playAnimation('run')
	
	setGravity(delta)
	
	player.move_and_slide()

func setGravity(delta):
	player.velocity.y += player.gravity * delta

func onInput(_event) -> void:
	if not Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		stateMachine.changeTo(player.states.idle)
