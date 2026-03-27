extends Control

@onready var SceneManager : Node = $"../../Managers/SceneManager"
@onready var GameManager : Node = $"../../Managers/GameManager"

func _on_play_btn_pressed() -> void:
	Events.emit_signal("start_game")

func _on_quit_btn_pressed() -> void:
	get_tree().quit();

func appear():
	visible = true

func diseapear():
	visible = false
