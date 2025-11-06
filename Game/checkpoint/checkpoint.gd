extends Node2D

@export var explosion_scene:PackedScene

func _on_body_entered(body: Node2D) -> void:
	CheckpointVar.checkpoint = global_position
	$".".set_deferred("monitoring",false)
	print(CheckpointVar.checkpoint)
	
	var explosionVFX:Node2D = explosion_scene.instantiate()
	owner.add_child(explosionVFX)
	explosionVFX.global_position = global_position
