extends Node

@onready var SceneManager = $"../SceneManager"
@onready var Battle_Manager = $"../BattleManager"

var first_level_path = preload("res://Scenes/Levels/level_test.tscn")
var second_level_path = preload("res://Scenes/Levels/level_2.tscn")
var LoadingPath = preload("res://Scenes/Levels/loading.tscn")

var level_list : Array [Level] =[]
var level_order : Array = []

var current_level : Node2D
 
func _ready():
	Events.restart_game.connect(_on_game_restart)
	Events.start_game.connect(_on_start_game)
	
	level_order.append(first_level_path)
	level_order.append(LoadingPath)
	level_order.append(second_level_path)
	

func Next_Level():
	if(level_order.is_empty()):
		SceneManager.end_game()
		return
	
	var scene = level_order.pop_front()
	current_level = scene.instantiate()
	
	SceneManager.next_level(current_level)
	
	if current_level is not Level:
		current_level.loading_finished.connect(_on_loading_finished)

func _on_level_ready():
	if current_level is Level:
		SceneManager.show_ui()
		Battle_Manager.start_encounter(current_level)

func _on_start_game():
	Next_Level()
	SceneManager.start_game()

func _on_loading_finished():
	Next_Level()
	
func _on_game_restart():
	SceneManager.restart_game()
