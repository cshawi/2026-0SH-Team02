extends Entity

# class parent qui fera juste le tour des actions principales
#chaque ennemi va heriter de Ennemi
class_name Ennemi
@export var target_manager : TargetManager
@export var stats : Basic_enemy_stats
@onready var click_area = $Area2D

signal clicked(enemy)

func _ready() -> void:
	add_to_group("enemies")
	print("enemy ready")
	click_area.clicked.connect(_on_clicked)

func start_turn():
	
	turn_state = Turn_state.ACTING
	choose_action()

#func choose_action():
	#
	#print(self , "essai de faire une action")
	#if(turn_state == Turn_state.ACTING):
		#var action = actions.pick_random()
		#var target = ai_choose_target()
		#print(target ," va etre attaquer avec : " , action.name )
		#perform_action(action, target)

func choose_action():
	print(self, "Trying to choose an action...")
	if turn_state != Turn_state.ACTING:
		print("Not in ACTING state, cannot choose action.")
		return
	
	if actions.is_empty():
		print("No available actions.")
		end_turn()
		return
	
	var action = actions.pick_random()
	var target = ai_choose_target()
	
	if target == null:
		print("No valid target found.")
		end_turn()
		return
	
	perform_action(action, target)  # This should also be tracked for successes or failures.


func ai_choose_target():
	var player_side = get_tree().get_nodes_in_group("player_side") # pas juste le joeur en cas si on creer des aident au autre
	
	if player_side.size() == 0:
		print("No targets available.")
		return null
	
	return player_side.pick_random()

func _on_clicked():
	if turn_state == Turn_state.WAITING:
		print("enemy clicked")
		clicked.emit(self)
