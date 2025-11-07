extends StaticBody2D
@export_group("settings")
@export var time_before_destroy : float = 1

@export_group("references")
@export var _cooldown : Timer
@export var animation : AnimationPlayer

var is_destroy : bool

func _ready() -> void:
	is_destroy = false
	_cooldown.wait_time = time_before_destroy

func _on_area_2d_body_entered(body: Node2D) -> void:
	if(is_destroy):return
	_cooldown.start() 
	animation.play("tremblement")

func _on_timer_timeout() -> void:
	if(is_destroy):return
	is_destroy = true
	animation.stop()
	animation.play("destroy")
	await animation.animation_finished
	queue_free()
