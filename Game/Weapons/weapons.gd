class_name Sword extends Area2D

@export var enemy: Node2D
@export var damage: int = 1

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		attack()
	
		
		
func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(1)
	await $SwordAnimation.animation_finished
	monitoring = false
	
func attack() -> void:
	monitoring = false
	$SwordAnimation.play("sword_attack")
	monitoring = true
