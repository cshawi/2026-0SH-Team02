class_name Entity
extends Node2D

@export var actions : Array[Action]

signal turn_finished# signal pour le game_manager et gestion du tour
enum Turn_state { ACTING , WAITING,DEAD }

var turn_state = Turn_state.WAITING

func _ready() -> void:
	turn_state = Turn_state.WAITING
			
func _process(delta: float) -> void:
	pass

func start_turn():
	turn_state = Turn_state.ACTING
	print(self, "Acting")
	
func end_turn(): # emit signal pour battle manager
	if(turn_state== Turn_state.ACTING):
		emit_signal("turn_finished")
		print("ending turn")
		turn_state = Turn_state.WAITING

func perform_action(action, enemy):
	if turn_state != Turn_state.ACTING:
		print("Attempting action while not acting!")
		return
	
	if action == null:
		print("ERROR: action null")
		end_turn()  # End turn if no action provided
		return
	
	action.execute(self, enemy)  # Execute the action

	# Ensure that action execution was successful
	print("Action executed, checking for completion...")
	if action.is_action_successful(action,enemy):  # Implement this method based on your action outcome
		print("Action was successful")
	else:
		print("Action failed, ending turn.")
	
	end_turn()  # End turn properly after action
