class_name Spike extends StaticBody2D
@export_group("references")
@export var spike_out_timer : Timer
@export var spike_in_timer : Timer
@export var cooldown : Timer
@export_group("settings")
@export var height : float = -30
@export var speed : float = 200
@export var strength : int =1
@export var spike_out_wait_time : float = 0.6
@export var spike_in_wait_time : float = 2
@export var is_movable : bool = true

var moving : bool
var destination : float
var startPosition : float
var returnToStart: bool
var _start_spike_system : bool
var _timer_start : bool
var move : Vector2 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	returnToStart = false
	_initialize()
	spike_in_timer.start()
	spike_out_timer.wait_time = spike_out_wait_time
	spike_in_timer.wait_time = spike_in_wait_time
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if _start_spike_system and is_movable:
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
	if global_position == move and !_timer_start:
		_timer_start = true
		if(returnToStart):
			spike_out_timer.start()
		else :
			spike_in_timer.start()

func _initialize()-> void:
	startPosition = global_position.y
	destination = global_position.y +height
			


func _on_spike_out_timer_timeout() -> void:
	_timer_start = false
	_start_spike_system = true
	moving = true


func _on_spike_in_timer_timeout() -> void:
	_timer_start = false
	_start_spike_system = true
	moving = true
