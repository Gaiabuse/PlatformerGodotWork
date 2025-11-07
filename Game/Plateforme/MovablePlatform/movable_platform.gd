extends AnimatableBody2D
enum axes{x,y}
@export_group("Settings")
##Required settings for the platform to function
@export var distance : float = 300
@export_enum("x","y") var axe:String
@export var speed : float = 200
var moving = false
var destination : float
var startPosition : float
var returnToStart: bool
var move : Vector2 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	returnToStart = false
	moving = true	
	_initialize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	go_there()
	global_position = global_position.move_toward(move, delta*speed)

'''Déplacement'''
func go_there():
	if moving :
		if(axe == "x"):
			if(returnToStart):
				move = Vector2(startPosition,global_position.y)
			else:

				move = Vector2(destination,global_position.y)
		else :
			if(returnToStart):
				move = Vector2(global_position.x,startPosition)
			else:
				move = Vector2(global_position.x,destination)
		returnToStart = !returnToStart
		moving = false
	if global_position == move:
		moving = true

func _initialize()-> void:
	if(axe == "x"):
		startPosition = global_position.x
		destination = global_position.x + distance
	else :
		startPosition = global_position.y
		destination = global_position.y +distance
