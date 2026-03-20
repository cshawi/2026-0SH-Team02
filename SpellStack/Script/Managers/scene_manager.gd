extends Node

@onready var LevelHolder: Node = $"../../LevelHolder"
@onready var MainMenu: Node = $"../../UI/MainMenu"
@onready var level_scene : Level = $"../../LevelHolder/LevelTest"
@onready var player : Player = $"../../player"
@onready var playerAction = $"../../UI/PlayerAction"

func _ready() -> void:
	pass # Replace with function body.

func start_game() -> void:
	MainMenu.diseapear()
	LevelHolder.visible = true
	level_scene.visible = true
	player.visible = true
	playerAction.visible = true
	
	
