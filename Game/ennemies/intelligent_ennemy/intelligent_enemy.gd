extends CharacterBody2D

@export var player: Node2D
@export var sprite: Sprite2D
@export var speed: int = 100
var health: int
var direction: Vector2 = Vector2.ZERO
@export var limiteA: int 
@export var limiteB: int
var target_position: Vector2 = Vector2.ZERO
var player_targeting: bool = false
@export var max_health: int
var _is_dead: bool = false

var _health: int:
	set(value):
		_health = value

func _ready() -> void:
	_health = max_health

func _physics_process(delta: float) -> void:
	if position.x < limiteA:
		target_position = Vector2(limiteB, 0)
		sprite.scale.x = 1
	elif position.x > limiteB:
		target_position = Vector2(limiteA, 0)
		sprite.scale.x = -1
	
	var target_direction: Vector2 = Vector2(global_position.direction_to(target_position).x,0)
	if player_targeting and limiteB > position.x and position.x > limiteA:
		target_direction = Vector2(global_position.direction_to(player.global_position).x,0)
	direction = lerp(direction, target_direction, delta)
	velocity = direction * speed
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	velocity *= 50
	move_and_slide()
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)
	if collision:
		var collider = collision.get_collider()
		if collider is Player:
			player.take_damage(1)


func _on_sight_area_body_entered(body: Node2D) -> void:
	if body == player:
		player_targeting = true

func _on_sight_area_body_exited(body: Node2D) -> void:
	if body == player:
		player_targeting = false

func die():
	if _is_dead:
		return
	_is_dead = true
	queue_free()

func take_damage(damage:int):
	_health = max(0, _health - damage)
	if _health == 0:
		die()
