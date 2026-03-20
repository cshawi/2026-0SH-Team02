extends Node

@onready var SceneManager = $"../SceneManager"
@onready var FirstLevel = $"../../LevelHolder/LevelTest"

var current_level : Level

var level_list : Array [Level] =[]
var level_order : Array[Level] = []
 
