extends Control

@export var player: Player

@export var empty_heart: GridContainer
@export var full_heart: GridContainer
var liste_coeur: Array[TextureRect]

func _ready() -> void:
	for i in range(player.max_health):
		var new_heart = preload("res://Game/UI/heart.tscn")
		var instance = new_heart.instantiate()
		full_heart.add_child(instance)
		liste_coeur.append(instance)
	player.lost_life.connect(lost_life)

func lost_life():
	var new_black_heart = preload("res://Game/UI/black_heart.tscn")
	var instance = new_black_heart.instantiate()
	liste_coeur[player._health] = instance
	full_heart.get_child(player._health).queue_free()
	full_heart.add_child(instance)
