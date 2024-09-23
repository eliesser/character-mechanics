class_name MachineState
extends Node

@export var animations: AnimatedSprite2D
@export var rayCastStuckOnWall: RayCastStuckOnWall
@export var timerRayCastStuckOnWall: Timer

@onready var player:Player = self.owner

enum State {
	idle,
	walk,
	idleCrouch,
	walkCrouch,
	run,
	jumpUp,
	jumpTop,
	jumpDown,
	airSpin,
	land,
	wallLand,
	climbLedge,
	wallSlide
}
const ANIMATIONS = [
	"idle", 
	"walk",
	"idleCrouch", 
	"walkCrouch",
	"run", 
	"jumpUp", 
	"jumpTop", 
	"jumpDown", 
	"airSpin",
	"land",
	"wallLand",
	"climbLedge",
	"wallSlide"
]

const JUMP_VELOCITY:int = -400
const SPEED_RUN:int = 300
const SPEED_WALL:int = 150
const GRAVITY = 980

var gravity = GRAVITY
var currentState:State = State.idle
var canDobleJump:bool = false

func _physics_process(delta: float) -> void:
	match currentState:
		State.idle:
			player.velocity.x = 0
			player.playAnimation(ANIMATIONS[State.idle])
			
			if Input.is_action_pressed("walkLeft") or Input.is_action_pressed("walkRight"):
				currentState = State.walk
			elif Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
				currentState = State.run
			elif Input.is_action_pressed("jump"):
				currentState = State.jumpUp
			elif Input.is_action_pressed("ui_down"):
				currentState = State.idleCrouch
			
		State.walk:
			player.velocity.x = Input.get_axis("ui_left", "ui_right") * SPEED_WALL
			player.playAnimation(ANIMATIONS[State.walk])
			
			if Input.is_action_pressed("jump"):
				currentState = State.jumpUp
			elif not Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
				currentState = State.idleCrouch
			elif Input.is_action_pressed("ui_down"):
				currentState = State.idleCrouch
			elif not Input.is_action_pressed("walkLeft") and not Input.is_action_pressed("walkRight"):
				currentState = State.idle
			
		State.idleCrouch:
			player.velocity.x = 0
			player.playAnimation(ANIMATIONS[State.idleCrouch])
			
			if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
				currentState = State.walkCrouch
			elif Input.is_action_pressed("jump"):
				currentState = State.jumpUp
			elif not Input.is_action_pressed("ui_down"):
				currentState = State.idle
			
		State.walkCrouch:
			player.velocity.x = Input.get_axis("ui_left", "ui_right") * (SPEED_WALL - 50)
			player.playAnimation(ANIMATIONS[State.walkCrouch])
			
			if Input.is_action_pressed("jump"):
				currentState = State.jumpUp
			elif not Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
				currentState = State.idleCrouch
			elif not Input.is_action_pressed("ui_down"):
				currentState = State.idle
			
		State.run:
			player.velocity.x = Input.get_axis("ui_left", "ui_right") * SPEED_RUN
			player.playAnimation(ANIMATIONS[State.run])
			
			if Input.is_action_pressed("jump"):
				currentState = State.jumpUp
			elif Input.is_action_pressed("walkLeft") or Input.is_action_pressed("walkRight"):
				currentState = State.walk
			elif Input.is_action_pressed("ui_down"):
				currentState = State.idleCrouch
			if not Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
				currentState = State.idle
			
		State.jumpUp:
			player.velocity.x = Input.get_axis("ui_left", "ui_right") * SPEED_RUN
			player.playAnimation(ANIMATIONS[State.jumpUp])
			
			if player.is_on_floor() and player.velocity.y == 0:
				player.velocity.y = JUMP_VELOCITY
			elif player.velocity.y > 0:
				canDobleJump = true
				currentState = State.jumpTop
			
		State.jumpTop:
			player.velocity.x = Input.get_axis("ui_left", "ui_right") * SPEED_RUN
			player.playAnimation(ANIMATIONS[State.jumpTop])
			
			if not player.is_on_floor() and Input.is_action_pressed("jump") and canDobleJump:
				currentState = State.airSpin
			
		State.jumpDown:
			player.velocity.x = Input.get_axis("ui_left", "ui_right") * SPEED_RUN
			player.playAnimation(ANIMATIONS[State.jumpDown])
			
			if player.is_on_floor() and player.velocity.y == 0:
				if player.velocity.x == 0:
					currentState = State.land
				else:
					currentState = State.run
			elif not player.is_on_floor() and Input.is_action_pressed("jump") and canDobleJump:
				currentState = State.airSpin
			elif rayCastStuckOnWall.is_colliding():
				if rayCastStuckOnWall.get_collider().is_in_group("groupWallLand"):
					currentState = State.wallLand
				elif rayCastStuckOnWall.get_collider().is_in_group("groupClimbLedge"):
					currentState = State.wallLand
				else:
					currentState = State.wallSlide
			
		State.airSpin:
			player.velocity.x = Input.get_axis("ui_left", "ui_right") * SPEED_RUN
			player.playAnimation(ANIMATIONS[State.airSpin])
			
			if canDobleJump:
				player.velocity.y = JUMP_VELOCITY
				canDobleJump = false
			
			if player.is_on_floor() and player.velocity.y == 0:
				if player.velocity.x == 0:
					currentState = State.land
				else:
					currentState = State.run
			elif rayCastStuckOnWall.is_colliding():
				if rayCastStuckOnWall.get_collider().is_in_group("groupWallLand"):
					currentState = State.wallLand
				elif rayCastStuckOnWall.get_collider().is_in_group("groupClimbLedge"):
					currentState = State.wallLand
			
		State.land:
			player.velocity.x = 0
			player.playAnimation(ANIMATIONS[State.land])
			
		State.wallLand:
			if gravity > 0:
				player.playAnimation(ANIMATIONS[State.wallLand])
				gravity = 0
				player.velocity.y = 0
			
			if Input.is_action_pressed("jump"):
				rayCastStuckOnWall.RAY_CAST_DIMENSION = 0
				gravity = GRAVITY
				timerRayCastStuckOnWall.start()
				canDobleJump = false
				player.velocity.y = JUMP_VELOCITY
				currentState = State.jumpUp
			
			elif Input.is_action_pressed("ui_down"):
				rayCastStuckOnWall.RAY_CAST_DIMENSION = 0
				gravity = GRAVITY
				timerRayCastStuckOnWall.start()
				currentState = State.jumpDown
			
			#elif Input.is_action_pressed("ui_up"):
				#rayCastStuckOnWall.RAY_CAST_DIMENSION = 0
				#timerRayCastStuckOnWall.start()
				#currentState = State.climbLedge
			
		State.climbLedge:
			player.playAnimation(ANIMATIONS[State.climbLedge])
			player.velocity.y = -110
			
		State.wallSlide:
			if rayCastStuckOnWall.is_colliding():
				if rayCastStuckOnWall.get_collider().is_in_group("groupWallLand"):
					currentState = State.wallLand
				elif rayCastStuckOnWall.get_collider().is_in_group("groupClimbLedge"):
					currentState = State.wallLand
				elif player.is_on_floor():
					currentState = State.land
					gravity = GRAVITY
				else:
					player.playAnimation(ANIMATIONS[State.wallSlide])
					gravity = 1
	
	setGravity(delta)
	
	player.move_and_slide()

func setGravity(delta):
	player.velocity.y += gravity * delta

func _on_animations_animation_finished() -> void:
	if animations.animation == ANIMATIONS[State.jumpTop]:
		currentState = State.jumpDown
	if animations.animation == ANIMATIONS[State.land]:
		currentState = State.idle
	if animations.animation == ANIMATIONS[State.climbLedge]:
		player.velocity.y = 0
		player.velocity.x = 5
		currentState = State.idle
		gravity = GRAVITY

func _on_timer_ray_cast_stuck_on_wall_timeout() -> void:
	rayCastStuckOnWall.RAY_CAST_DIMENSION = 7
