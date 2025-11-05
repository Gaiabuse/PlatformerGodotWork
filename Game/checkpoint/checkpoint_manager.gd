extends Node2D

@export var player:CharacterBody2D

func _process(delta: float) -> void:
	if Input.is_action_pressed("test_checkpoint"):
		player.global_position = (checkpointVar.checkpoint)
