extends Node2D

@export var player:CharacterBody2D

var checkpoint:Vector2


func _process(delta: float) -> void:
	if Input.is_action_pressed("test_checkpoint"):
		player.global_position = checkpoint


func _on_body_entered(body: Node2D) -> void:
	checkpoint = body.global_position
	print(checkpoint)
