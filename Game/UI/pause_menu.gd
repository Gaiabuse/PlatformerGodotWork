extends Control

var pause : bool

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	pause = false
	hide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		pause_unpause()

func pause_unpause() -> void:
	pause = !pause
	if pause:
		get_tree().paused = true
		show()
	else:
		get_tree().paused = false
		hide()

func _on_play_button_button_up() -> void:
	pause_unpause()


func _on_main_menu_button_button_up() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Game/UI/StartMenu.tscn")
	
