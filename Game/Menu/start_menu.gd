extends Control
##path of the first level
@export var first_level : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_start_pressed() -> void:
	print("apagnan")
	get_tree().change_scene_to_file(first_level)


func _on_button_quit_pressed() -> void:
	get_tree().quit() # Replace with function body.
