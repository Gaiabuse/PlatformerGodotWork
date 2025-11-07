extends Node2D

@export var next_level : String
@export var first_checkpoint : Vector2 = Vector2(0,0)

func _on_area_2d_body_entered(body: Node2D) -> void:
	#Passer au niveau suivant, reset vie et checkpoint
	CheckpointVar.checkpoint = first_checkpoint
	player_life.life = 5
	get_tree().change_scene_to_file(next_level)
