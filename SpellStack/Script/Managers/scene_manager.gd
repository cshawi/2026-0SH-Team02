extends Node

@onready var LevelHolder: Node = $"../../LevelHolder"
@onready var MainMenu: Node = $"../../UI/MainMenu"
@onready var level_scene = load("res://scenes/level_test.tscn")
@onready var level_instance = level_scene.instantiate()


func _ready() -> void:
	pass # Replace with function body.

func start_game() -> void:
	for child in LevelHolder.get_children():
		child.queue_free()
	
	MainMenu.diseapear()
	
	LevelHolder.add_child(level_instance)
