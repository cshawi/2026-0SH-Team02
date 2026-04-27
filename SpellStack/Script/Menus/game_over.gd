extends Control

var can_reset : bool = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") and can_reset:
		Events.emit_signal("restart_game")
	
	if(self.visible == true):
		can_reset = true
