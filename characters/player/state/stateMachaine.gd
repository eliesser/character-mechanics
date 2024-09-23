class_name StateMachine extends Node

@onready var controllerNode:Node = self.owner

@export var defaultState: StateBase
@export var animations: AnimatedSprite2D

var currentState: StateBase = null

func _ready() -> void:
	call_deferred("stateDefaultStart")

func stateDefaultStart() -> void:
	currentState = defaultState
	stateStart()

func stateStart() -> void:
	print("StateMachine: ", controllerNode.name, " - start state: ", currentState.name)
	currentState.controllerNode = controllerNode
	currentState.stateMachine = self
	currentState.start()

func changeTo(nextState:String) -> void:
	if currentState and currentState.has_method("end"): currentState.end()
	
	currentState = get_node(nextState)
	stateStart()

func _process(delta:float) -> void:
	if currentState and currentState.has_method("onProcess"):
		currentState.onProcess(delta)

func _physics_process(delta: float) -> void:
	if currentState and currentState.has_method("onPhysicsProcess"):
		currentState.onPhysicsProcess(delta)

func _input(event: InputEvent) -> void:
	if currentState and currentState.has_method("onInput"):
		currentState.onInput(event)

func _unhandled_input(event: InputEvent) -> void:
	if currentState and currentState.has_method("onUnhandledInput"):
		currentState.onUnhandledInput(event)

func _unhandled_key_input(event: InputEvent) -> void:
	if currentState and currentState.has_method("onUnhandledKeyInput"):
		currentState.onUnhandledKeyInput(event)

func _on_animations_animation_finished() -> void:
	currentState.onAnimationFinish(animations.animation)
