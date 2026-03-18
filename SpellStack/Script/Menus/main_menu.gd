extends Control

@onready var SceneManager : Node = $"../../Managers/SceneManager"
@onready var GameManager : Node = $"../../Managers/GameManager"

func _on_play_btn_pressed() -> void:
	SceneManager.start_game()
	# appeler le game manager pour commencer la partie
	pass # Replace with function body.

func _on_quit_btn_pressed() -> void:
	get_tree().quit();

func appear():
	visible = true

func diseapear():
	visible = false
