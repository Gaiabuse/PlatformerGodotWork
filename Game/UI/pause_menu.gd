extends Control
##path of the first level
@export var level_1 : String
@export var level_2 : String
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

func _on_quit_button_button_up() -> void:
	get_tree().quit()
