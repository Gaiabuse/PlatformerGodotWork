extends Node2D

var checkpoint:Vector2

func _on_body_entered(body: Node2D) -> void:
	checkpoint = global_position
	print(checkpoint)
	queue_free()
