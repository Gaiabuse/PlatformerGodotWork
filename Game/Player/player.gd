class_name Player
extends CharacterBody2D

signal lost_life
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@export var camera: Camera2D
@export var max_health: int
@export var anchor: Node2D
@export var epee_scene: PackedScene
@export var laserpistol_scene: PackedScene
var epee: Sword
var laser_pistol: Pistol
var _is_dead: bool = false
var epee_instantiate: bool = false
var laserpistol_instantiate: bool = false

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
	
	if Input.is_action_just_pressed("test_checkpoint"):
		teleport_to_checkpoint()
		
	if Input.is_action_just_pressed("switch_weapon"):
		switch_weapon()
	
func die():
	if _is_dead:
		return

	_is_dead = true
	queue_free()
	
func take_damage(damage:int):
	_health = max(0, _health - damage)
	lost_life.emit()
	if _health == 0:
		die()
	
func teleport_to_checkpoint():
	global_position = CheckpointVar.checkpoint
	
func instantiate_epee() -> void:
	if epee_instantiate:
		return
	print("instancier")
	epee = epee_scene.instantiate()
	add_child(epee)
	epee.global_position = anchor.global_position
	epee.owner = owner
	epee_instantiate = true
	
func instantiate_laserpistol()-> void:
	if laserpistol_instantiate:
		return
	print("instancier")
	laser_pistol = laserpistol_scene.instantiate()
	add_child(laser_pistol)
	laser_pistol.global_position = anchor.global_position
	laser_pistol.owner = owner

	laserpistol_instantiate = true
func switch_weapon()->void:
	if epee_instantiate:
		epee.queue_free()
		epee = null
		instantiate_laserpistol()
		epee_instantiate = false
	else:
		laser_pistol.queue_free()
		laser_pistol = null
		instantiate_epee()
		laserpistol_instantiate = false
