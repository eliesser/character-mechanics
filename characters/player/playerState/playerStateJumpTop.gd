class_name PlayerStateTop extends StateBase

var player: Player

func start():
	player = controllerNode

func onPhysicsProcess(delta: float) -> void:
	player.velocity.x = Input.get_axis("ui_left", "ui_right") * player.SPEED_RUN
	player.playAnimation('jumpTop')
	
	setGravity(delta)
	
	player.move_and_slide()

func setGravity(delta):
	player.velocity.y += player.gravity * delta

func onInput(_event) -> void:
	if not player.is_on_floor() and Input.is_action_pressed("jump") and player.canDobleJump:
		stateMachine.changeTo(player.states.airSpin)

func onAnimationFinish(animationName:String) -> void:
	if animationName == 'jumpTop':
		stateMachine.changeTo(player.states.jumpDown)
