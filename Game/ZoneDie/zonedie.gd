extends Area2D

var _current_target: Player

func _on_body_entered(body: Player) -> void:
	body.die()
