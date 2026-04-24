class_name Entity
extends Node2D

@export var actions : Array[Action]

signal turn_finished(actor)# signal pour le game_manager et gestion du tour
enum Turn_state { ACTING , WAITING,DEAD,NONE }

var turn_state = Turn_state.WAITING

func _ready() -> void:
	turn_state = Turn_state.WAITING
			
func _process(_delta: float) -> void:
	pass

func start_turn():
	turn_state = Turn_state.ACTING
	print(self, "Acting")
	
func end_turn(): # emit signal pour battle manager
	if(turn_state== Turn_state.ACTING):
		turn_state = Turn_state.WAITING
		print(self.name, " ending turn")
		turn_finished.emit(self)

func perform_action(action, enemy) -> void:
	if turn_state != Turn_state.ACTING:
		print("Attempting action while not acting!")
		return
	
	if action == null:
		print("ERROR: action ou carte null")
		end_turn()  # End turn if no action provided
		return
	
	if(self is Player):
		action.play(self, enemy) 
		print(self.playerDeck.playerHand)
		self.playerDeck.playerHand.remove_card_from_hand(action)
		print(self.playerDeck.playerHand)
	else:
		action.execute(self, enemy)  # Execute the of reguar entity with no cards

	# Ensure that action execution was successful
	#print("Action executed, checking for completion...")
	#if action.is_action_successful(action,enemy):  # Implement this method based on your action outcome
		#print("Action was successful")
	#else:
		#print("Action failed, ending turn.")
	
	end_turn()  # End turn properly after action
