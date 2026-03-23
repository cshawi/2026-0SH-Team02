extends Node2D

signal loading_finished

func _on_loading_time_timeout() -> void:
	emit_signal("loading_finished")
