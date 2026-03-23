extends Node

@onready var SceneManager = $"../SceneManager"
@onready var Battle_Manager = $"../BattleManager"
@onready var first_level = $"../../LevelHolder/LevelTest"

var SecondLevelPath = preload("res://Scenes/Levels/level_2.tscn")
var LoadingPath = preload("res://Scenes/Levels/loading.tscn")

var level_list : Array [Level] =[]
var level_order : Array = []

var current_level : Node2D = first_level
 
func _ready():
	var second_level = SecondLevelPath.instantiate()
	var loading_screen = LoadingPath.instantiate()
	loading_screen.loading_finished.connect(_on_loading_finished)
	Events.restart_game.connect(_on_game_restart)
	
	level_list.append(first_level)
	level_list.append(second_level)
	
	level_order.append(loading_screen)
	level_order.append(second_level)
	

func Next_Level():
	if(level_order.is_empty()):
		SceneManager.end_game()
		return
	
	current_level = level_order.pop_front()
	SceneManager.next_level(current_level)
	
	if current_level is Level:
		SceneManager.show_player()
		Battle_Manager.start_encounter()

func _on_loading_finished():
	Next_Level()
	
func _on_game_restart():
	SceneManager.restart_game()
