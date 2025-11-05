class_name Player
extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@export var camera: Camera2D
@export var max_health: int
@export var anchor: Node2D
@export var epee_scene: PackedScene
var epee: StaticBody2D
var _is_dead: bool = false
var epee_instantiate: bool = false

var _health: int:
	set(value):
		_health = value


func _ready() -> void:
	_health = max_health
	epee_instantiate = false
	instantiate_epee()


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	if Input.is_action_pressed("test_checkpoint"):
		teleport_to_checkpoint()
	
func die():
	if _is_dead:
		return

	_is_dead = true
	teleport_to_checkpoint()
	
func take_damage(damage:int):
	_health = max(0, _health - damage)
	if _health == 0:
		die()
	
func teleport_to_checkpoint():
	global_position = CheckpointVar.checkpoint
