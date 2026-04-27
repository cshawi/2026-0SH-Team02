extends Control

class_name skipButton

func _ready():
	pass
	

func _on_pressed() -> void:
	Events.skip_turn.emit()
	print("Skip turn pressed")
