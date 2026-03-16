extends Node

class_name Battle_manager

@export var player_character : Player
@export var enemies_character : Array[Ennemi] # voir la mecanique de packed scene pour prendre les ennemies selont genre le lvl de l'encounter pour prochain livrable

var current_character : Entity # a changer pour plus tard Celui qui a le tour

var character_list : Array [Entity] =[]
var turn_order : Array[Entity] = [] 
var current_round :int =0

var enemies : Array[Ennemi] = []
var game_over : bool = false

#fait le tour des etats dun encounter
enum Encounter { NONE, START, IN_ENCOUNTER ,END   } 
var encounter_state : Encounter = Encounter.NONE

func _ready() -> void:
	if player_character == null:
		print("error player not found");
	else:
		print("player ready")
		
func _process(delta: float) -> void:
	if game_over:
		return
	
	match encounter_state:	
		Encounter.NONE:
			print("State :NONE --> Entering Start State (test)");
			start_encounter()
			
		Encounter.START:
			#print("START");
			start_encounter();
			
		Encounter.IN_ENCOUNTER:
			# print("IN_ENCOUNTER");
			pass
		Encounter.END:
			
			print("END");	
			#get_tree().exit()
		_:
			print("OUT OF THE ENUM OF ENCOUNTER");
			
func connectionVerif():
	for actor in turn_order:
		if !actor.turn_finished.is_connected(end_turn):
			print("Connecting signal for", actor)
			actor.turn_finished.connect(end_turn)
			
			

func start_encounter():
	summonEncounter();
	character_list.append(player_character)
	character_list.append_array(enemies_character)
	encounter_state = Encounter.IN_ENCOUNTER
	start_round()
	
	
func enter_encounter(): # fait juste summon pour l'instant
	
	character_list.append(player_character)
	for enemy in enemies:
		character_list.append(enemy)
		
	encounter_state = Encounter.IN_ENCOUNTER
	start_round();
		
func summonEncounter():
	print("ennemy summoned")
	for enemy in enemies_character:
		enemies.append(enemy) 

func end_encounter():
	print("Encounter Ended")
	
	
func pv_verif():
	var to_remove = []
	for entity in character_list:
		if entity.stats.current_hp <= 0:
			to_remove.append(entity)
		
	for entity in to_remove:
		character_list.erase(entity)
		turn_order.erase(entity)
	
func end_turn():
	pv_verif()  # Remove characters with 0 HP
	print("Character status end turn")
	for entity in character_list:
		print("Character HP states:", entity.stats.current_hp )
	
	# Ensure current_character is still valid in turn_order
	if current_character and turn_order.has(current_character):
		turn_order.erase(current_character)

	if turn_order.is_empty():
		print("No more characters left. Starting a new round...")
		start_round()  # Call to start the next round
	else:
		print("Proceeding to the next turn...")
		if turn_order.size() > 0:
			start_turn()  # Continue to the next character's turn
			
			
func start_round():
	print("Starting Round")
	turn_order.clear()

	# Populate turn_order with alive characters
	for entity in character_list:
		if entity.stats.current_hp > 0:
			turn_order.append(entity)

	if turn_order.is_empty():
		print("All characters are down. Game Over!")
		game_over = true
		return

	connectionVerif()  # Ensure each character has signals connected
	start_turn()

func start_turn():
	print("Current turn order before action: ", turn_order)
	if turn_order.is_empty():
		print("Turn order is empty, starting new round")
		start_round()  # Start a new round if no turns are left
		return

	current_character = turn_order.pop_front()
	print(current_character.name, "is now acting.")
	current_character.start_turn()
	
