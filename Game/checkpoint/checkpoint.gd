extends Node2D

@export var explosion_scene:PackedScene

func _on_body_entered(body: Node2D) -> void:
	#Set checkpoint position
	CheckpointVar.checkpoint = global_position
	
	#Checkpoint sond
	$CheckpointSound.play()
	
	#Désactive pour pas le reprendre
	$".".set_deferred("monitoring",false)
	
	#Explosion VFX
	var explosionVFX:Node2D = explosion_scene.instantiate()
	owner.add_child(explosionVFX)
	explosionVFX.global_position = global_position
