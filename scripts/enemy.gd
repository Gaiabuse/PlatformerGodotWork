extends CharacterBody2D

@export var player: Node2D
@export var sprite: Sprite2D
#@export var gunSprite: Sprite2D
@export var speed: int = 100
var health: int
var direction: Vector2 = Vector2.ZERO
@export var limiteA: int 
@export var limiteB: int
var target_position: Vector2 = Vector2.ZERO

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	if position.x < limiteA:
		target_position = Vector2(limiteB, 0)
		#gunSprite.global_position.x -= 50
		sprite.scale.x = 1
		#gunSprite.scale.x = 1
	elif position.x > limiteB:
		target_position = Vector2(limiteA, 0)
		#gunSprite.global_position.x += 50
		#gunSprite.scale.x = 1
		sprite.scale.x = -1
	
	
	var target_direction: Vector2 = Vector2(global_position.direction_to(target_position).x,0)
	direction = lerp(direction, target_direction, delta)
	velocity = direction * speed
	
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	velocity *= 50
	move_and_slide()


func _on_sight_area_body_entered(body: Node2D) -> void:
	player = body


func _on_sight_area_body_exited(body: Node2D) -> void:
	player = null
	
