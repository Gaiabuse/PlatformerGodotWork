extends Control

@export var player: Player

@export var empty_heart: GridContainer
@export var full_heart: GridContainer
@export var number_of_bullet: Label
@export var number_of_life: Label
var liste_coeur: Array[TextureRect]
func _ready() -> void:
	for i in range(player.max_health):
		var new_heart = preload("res://Game/UI/heart.tscn")
		var instance = new_heart.instantiate()
		full_heart.add_child(instance)
		liste_coeur.append(instance)
	number_of_bullet.text = str(inventory_manager.bullet_number)
	number_of_life.text = str(player_life.life)
	player.lost_health.connect(lost_health)
	player.lost_life.connect(modify_life_number)
	player.remove_health.connect(remove_health)
	inventory_manager.change_bullet_number.connect(modify_bullet_number)

func lost_health():
	var new_black_heart = preload("res://Game/UI/black_heart.tscn")
	var instance = new_black_heart.instantiate()
	liste_coeur[player._health] = instance
	full_heart.get_child(player._health).queue_free()
	full_heart.add_child(instance)

func remove_health():
	for i in full_heart.get_child_count():
		full_heart.get_child(i).queue_free()
	for i in range(player.max_health):
		var new_heart = preload("res://Game/UI/heart.tscn")
		var instance = new_heart.instantiate()
		full_heart.add_child(instance)
func modify_bullet_number():
	number_of_bullet.text = str(inventory_manager.bullet_number)
func modify_life_number():
	number_of_life.text = str(player_life.life)
	
