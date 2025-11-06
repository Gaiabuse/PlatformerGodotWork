class_name Pistol extends Node2D
@export_group("References")
@export var anchor: Node2D
@export var bulletScene: PackedScene
@export var CoolDown: Timer
@export var marker : Marker2D
var is_right : bool
var _canShoot: bool


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_canShoot = true
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var rotation = get_global_mouse_position()
	if(is_right):
		rotation.x = global_position.x + 100
	else:
		rotation.x = global_position.x - 100
	anchor.look_at(rotation)
	if (Input.is_action_just_pressed("attack")):
		_shoot()

func _shoot() -> void:
	if (_canShoot && inventory_manager.bullet_number >0):
		CoolDown.start()
		var projectile: StaticBody2D = bulletScene.instantiate()
		owner.add_child(projectile)
		projectile.global_position = marker.global_position
		projectile.global_rotation = anchor.global_rotation
		inventory_manager.bullet_number -=1
		$LaserPistolAudio.play()
		_canShoot = false


func _on_cooldown_timeout() -> void:
	_canShoot = true # Replace with function body.
