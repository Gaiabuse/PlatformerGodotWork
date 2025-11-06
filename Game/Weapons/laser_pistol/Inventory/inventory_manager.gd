extends Node

signal change_bullet_number
var bullet_number : int
var start_bullet_number : int = 10
func _ready() -> void:
	bullet_number = start_bullet_number
