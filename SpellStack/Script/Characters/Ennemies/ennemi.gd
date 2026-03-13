extends Entity

# class parent qui fera juste le tour des actions principales
#chaque ennemi va heriter de Ennemi
class_name Ennemi

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass


func start_turn():
	pass


func end_turn():
	emit_signal("turn_finished")
