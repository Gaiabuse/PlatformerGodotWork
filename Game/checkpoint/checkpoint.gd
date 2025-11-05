extends Node2D


func _on_body_entered(body: Node2D) -> void:
	CheckpointVar.checkpoint = global_position
	queue_free()
	print(CheckpointVar.checkpoint)
