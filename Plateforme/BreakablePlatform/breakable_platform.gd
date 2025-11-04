extends StaticBody2D

@export var _cooldown : Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	_cooldown.start() # Replace with function body.


func _on_timer_timeout() -> void:
	queue_free()
