class_name Player
extends CharacterBody2D

@export var camera: Camera2D
@export var max_health: int
@export var anchor: Node2D
@export var epee_scene: PackedScene
@export var laserpistol_scene: PackedScene
signal lost_health
signal lost_life
signal remove_health
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var epee: Sword
var laser_pistol: Pistol
var _is_dead: bool = false
var epee_instantiate: bool = false
var laserpistol_instantiate: bool = false
var is_right: bool
var _health: int:
	set(value):
		_health = value
var can_take_damage: bool = true
var _start_pos:Vector2



func _ready() -> void:
	if(player_life.life <=0):
		_start_pos = global_position
		player_life.life = player_life.max_life
		lost_life.emit()
	else:
		teleport_to_checkpoint()
	_health = max_health
	epee_instantiate = false
	is_right = true
	instantiate_epee()

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$JumpPlayer.play()

	var direction: float = Input.get_axis("move_left", "move_right")
	velocity.x = direction * SPEED
	if velocity.x > 0:
		is_right = true
		global_scale.x = 1
		global_rotation_degrees = 0
		if (laser_pistol != null):
			laser_pistol.global_scale.x = 1
			laser_pistol.global_rotation_degrees = 0
			laser_pistol.is_right = true
	elif velocity.x < 0:
		is_right = false
		global_scale.x = -1
		global_rotation_degrees = 180
		if (laser_pistol != null):
			laser_pistol.global_scale.x = -1
			laser_pistol.global_rotation_degrees = 180
			laser_pistol.is_right = false

	move_and_slide()

	if Input.is_action_just_pressed("test_checkpoint"):
		teleport_to_checkpoint()

	if Input.is_action_just_pressed("switch_weapon"):
		switch_weapon()


func die():
	player_life.life -=1
	lost_life.emit()
	LevelReload.reload()
	inventory_manager.bullet_number = inventory_manager.start_bullet_number
	
func take_damage(damage: int) -> void:
	print(can_take_damage)
	if not can_take_damage:
		return
	can_take_damage = false
	_health = max(0, _health - damage)
	lost_health.emit()
	$DiePlayer.play()

	if _health == 0:
		die()
		return

	var blink_time := 3.0
	var blink_interval := 0.1
	var timer := 0.0

	set_collision_layer_value(1, false) 
	set_collision_mask_value(4, false) 

	while timer < blink_time:
		visible = not visible
		await get_tree().create_timer(blink_interval).timeout
		timer += blink_interval

	visible = true
	set_collision_layer_value(1, true)
	set_collision_mask_value(4, true)
	can_take_damage = true


func teleport_to_checkpoint():
	global_position = CheckpointVar.checkpoint
	_is_dead = false


func instantiate_epee() -> void:
	if epee_instantiate:
		return
	epee = epee_scene.instantiate()
	add_child(epee)
	epee.global_position = anchor.global_position
	epee.owner = owner
	epee_instantiate = true


func instantiate_laserpistol() -> void:
	if laserpistol_instantiate:
		return
	laser_pistol = laserpistol_scene.instantiate()
	add_child(laser_pistol)
	laser_pistol.global_position = anchor.global_position
	laser_pistol.owner = owner
	if is_right:
		laser_pistol.global_scale.x = 1
		laser_pistol.global_rotation_degrees = 0
		laser_pistol.is_right = true
	else:
		laser_pistol.global_scale.x = -1
		laser_pistol.global_rotation_degrees = 180
		laser_pistol.is_right = false

	laserpistol_instantiate = true


func switch_weapon() -> void:
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
