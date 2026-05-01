extends Node

@onready var LevelHolder: Node = $"../../LevelHolder"
@onready var MainMenu: Node = $"../../UI/MainMenu"
@onready var player : Player = $"../../player"
#@onready var playerAction = $"../../UI/PlayerAction"
@onready var playerUI = $"../../UI/Hud"

@onready var win_ui = $"../../UI/WinUi"
@onready var game_over = $"../../UI/GameOver"
@onready var Game_Manager = $"../GameManager"

func _ready() -> void:
	pass # Replace with function body.

func start_game() -> void:
	MainMenu.diseapear()
	LevelHolder.visible = true
	player.visible = true
	playerUI.visible = true
	SoundManager.play_music()

func next_level(currentScene):
	for child in LevelHolder.get_children():
		child.queue_free()

	hide_ui()
	print(currentScene.name)

	LevelHolder.call_deferred("add_child", currentScene)
	call_deferred("_after_level_loaded")

func end_game():
	for child in LevelHolder.get_children():
		child.queue_free()
	win_ui.visible = true
	SoundManager.play_win_game()

func restart_game():
	get_tree().reload_current_scene()

func show_ui():
	#playerAction.visible = true
	player.visible = true
	playerUI.visible =true
	
func hide_ui():
	#playerAction.visible = false
	player.visible = false
	playerUI.visible =false

func _after_level_loaded():
	Game_Manager._on_level_ready()

func player_death():
	for child in LevelHolder.get_children():
		child.queue_free()
	game_over.visible = true
