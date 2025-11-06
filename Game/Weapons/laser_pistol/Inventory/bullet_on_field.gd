extends Area2D
@export var animation : AnimationPlayer
var obtained_bullet
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if obtained_bullet and body is not Player: return
	inventory_manager.bullet_number +=1
	inventory_manager.change_bullet_number.emit()
	animation.play("obtained")
	await animation.animation_finished
	queue_free()
	
