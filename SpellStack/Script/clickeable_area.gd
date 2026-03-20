extends Area2D
class_name Able_click
# utiliser pour la detection de clicks sur les ennemies

signal clicked

func _input_event(_viewport, event, _shape_idx):

	if event is InputEventMouseButton and event.pressed:
		clicked.emit()
