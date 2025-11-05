extends StaticBody2D

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		attack()


func attack() -> void:
	$SwordAnimation.play("sword_attack")
