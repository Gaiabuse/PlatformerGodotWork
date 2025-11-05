extends PhysicsBody2D

@export var speed: float = 800.0
@export var damage: int = 1
@export var cooldown : Timer
var _direction: Vector2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	_direction = Vector2.RIGHT.rotated(global_rotation)
	var velocity: Vector2 = _direction * speed * delta
	
	var collision: KinematicCollision2D = move_and_collide(velocity)
	
	if collision:
		var collider: Node2D = collision.get_collider() 
		if collider.is_in_group("obstacles"):
			queue_free()
		"""elif collider.is_in_group("enemies"):
			collider.take_damage(damage)"""
		


func _on_timer_timeout() -> void:
	queue_free() 
