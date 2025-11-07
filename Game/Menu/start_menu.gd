extends Control
@export var level_1 : String

func _on_start_button_button_up() -> void:
	get_tree().change_scene_to_file(level_1)
	CheckpointVar.checkpoint = Vector2(588,343)


func _on_quit_button_button_up() -> void:
	get_tree().quit()
