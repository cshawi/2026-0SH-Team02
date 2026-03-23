extends Node

@onready var LevelHolder: Node = $"../../LevelHolder"
@onready var MainMenu: Node = $"../../UI/MainMenu"
@onready var level_scene : Level = $"../../LevelHolder/LevelTest"
@onready var player : Player = $"../../player"
@onready var playerAction = $"../../UI/PlayerAction"
@onready var win_ui = $"../../UI/WinUi"

func _ready() -> void:
	pass # Replace with function body.

func start_game() -> void:
	MainMenu.diseapear()
	LevelHolder.visible = true
	level_scene.visible = true
	player.visible = true
	playerAction.visible = true

func next_level(currentScene):
	#changer à la currentScene
	for child in LevelHolder.get_children():
		child.queue_free()
		
	hide_player()
	LevelHolder.add_child(currentScene)

func end_game():
	for child in LevelHolder.get_children():
		child.queue_free()
	win_ui.visible = true

func restart_game():
	get_tree().reload_current_scene()

func show_player():
	player.visible = true
	
func hide_player():
	player.visible = false
