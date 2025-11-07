extends Area2D
@export_group("references")
@export var spike : Spike

var strength : int
var cooldown : Timer
var _is_touched :bool
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	strength = spike.strength
	cooldown = spike.cooldown


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Player) -> void:
	if _is_touched :return
	_is_touched = true
	print(strength)
	body.take_damage(strength)
	cooldown.start()


func _on_cooldown_timeout() -> void:
	_is_touched = false
