extends Entity

class_name Player

@export var player_stats : Player_stats

signal turn_finished# signal pour le game_manager et gestion du tour

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func start_turn():
	pass


func end_turn():
	emit_signal("turn_finished")
