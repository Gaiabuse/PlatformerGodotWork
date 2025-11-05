extends StaticBody2D
@export_group("references")
@export var animation : AnimationPlayer
@export var spike_out_timer : Timer
@export var spike_in_timer : Timer
@export_group("settings")
@export var height : float
@export var speed : float = 200
var moving : bool
var destination : float
var startPosition : float
var returnToStart: bool
var _start_spike_system : bool
var move : Vector2 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	returnToStart = false
	spike_in_timer.start()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if _start_spike_system :
		spike_moving()
		global_position = global_position.move_toward(move, delta*speed)
	
func spike_moving():
	if moving :
		if(returnToStart):
			move = Vector2(global_position.x,startPosition)
		else:
			move = Vector2(global_position.x,destination)
		returnToStart = !returnToStart
		moving = false
	if global_position == move:
		if(returnToStart):
			spike_out_timer.start()
		else :
			spike_in_timer.start()

func _initialize()-> void:
	startPosition = global_position.y
	destination = global_position.y +height
			


func _on_spike_out_timer_timeout() -> void:
	_start_spike_system = true
	moving = true


func _on_spike_in_timer_timeout() -> void:
	_start_spike_system = true
	moving = true
