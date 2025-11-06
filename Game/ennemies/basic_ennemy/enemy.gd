extends CharacterBody2D

#Element extérieur
@export var sprite: Sprite2D
var player: Player

#Statistiques de l'ennemi
@export var speed: int = 100
@export var max_health: int
var _health: int:
	set(value):
		_health = value
var _is_dead: bool = false

#Limite de déplacement
@export var limiteGauche: int 
@export var limiteDroite: int

#Direction
var direction: Vector2 = Vector2.ZERO
var target_direction: Vector2 = Vector2.ZERO
var target_position: Vector2 = Vector2.ZERO

#Gestion des damages sur le joueur
@export var timer : Timer
var _is_attack: bool = false
var attacking: Player

func _ready() -> void:
	_health = max_health
	limiteGauche = position.x - limiteGauche
	limiteDroite += position.x


func _process(delta: float) -> void:
	#Attaque
	if attacking:
		make_damage(attacking)

func _physics_process(delta: float) -> void:
	
	_direction()
	
	#Applique les déplacements vers la direction
	direction = lerp(direction, target_direction, delta)
	velocity = direction * speed
	
	if direction.x < 0:
		sprite.scale.x = -1
	else :
		sprite.scale.x = 1
	
	#Gravité
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	velocity *= 50
	move_and_slide()

'''Gestion de la direction'''
func _direction() -> void:
	if position.x < limiteGauche:
		target_position = Vector2(limiteDroite, 0)
		sprite.scale.x = 1
	elif position.x > limiteDroite:
		target_position = Vector2(limiteGauche, 0)
		sprite.scale.x = -1
	target_direction = Vector2(global_position.direction_to(target_position).x,0)
	if player:
		target_direction = Vector2(global_position.direction_to(player.global_position).x,0)

'''Gestion de la détection du joueur'''
func _on_sight_area_body_entered(body: Node2D) -> void:
	if body is Player:
		player = body

func _on_sight_area_body_exited(body: Node2D) -> void:
	if body is Player:
		player = null

'''Gestion des dégâts'''
func _on_collision_area_body_entered(body: Node2D) -> void:
	if body is Player:
		attacking = body

func _on_collision_area_body_exited(body: Node2D) -> void:
	attacking = null

func make_damage(body: Node2D) -> void:
	if !_is_attack:
		body.take_damage(1)
		timer.start()
		_is_attack = true

func _on_timer_timeout() -> void:
		_is_attack = false

'''Gestion de la vie'''
func take_damage(damage:int):
	_health = max(0, _health - damage)
	if _health == 0:
		die()

func die():
	if _is_dead:
		return
	$animation.play("died")
	$CollisionShape2D.set_deferred("disabled", true)
	_is_dead = true
	await  $animation.animation_finished
	queue_free()
