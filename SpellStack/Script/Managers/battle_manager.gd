extends Node

class_name Battle_manager

@export var player_character : Player
var enemies_character : Array[Ennemi] # voir la mecanique de packed scene pour prendre les ennemies selont genre le lvl de l'encounter pour prochain livrable

@onready var game_over_ui = get_node_or_null("../../UI/GameOver")# a deplacer dans game manager dans 3e livrable 
@onready var win_ui = get_node_or_null("../../UI/WinUi")
@onready var Game_Manager = $"../GameManager"

var level_holder : Node2D
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
		
func _process(_delta: float) -> void:
	if game_over:
		return
	
	match encounter_state:	
		Encounter.NONE:
			pass
			#start_encounter()
			
		Encounter.START:
			#print("START");
			enter_encounter();
			
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

func start_encounter(level):
	enemies_character.clear()
	enemies.clear()
	character_list.clear()
	turn_order.clear()
	
	for child in level.get_children():
		if child is Ennemi:
			print("nouvel ennemi reconnu")
			enemies_character.append(child)
	
	print(enemies_character)
	summonEncounter()
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
	
	
# check les pv
func pv_verif(): 
	var to_remove = []
	for entity in character_list:
		if not is_instance_valid(entity):
			continue

		if entity.stats.current_hp <= 0:
			print(entity)
			to_remove.append(entity)
		
	for entity in to_remove:
		entity.turn_state = entity.Turn_state.DEAD
		character_list.erase(entity)
		turn_order.erase(entity)
		
		# dire à l'entité de jouer son animation de mort 
		if(entity is Ennemi):
			await entity._on_death()
		
		entity.queue_free()
		
	if(!character_list.has(player_character)):
		encounter_state = Encounter.END
		game_over = true;
		print("Le player est mort!")
		#get_tree().paused = true
		#game_over_ui.visible = true
		Game_Manager.player_death()
		character_list.clear()
		turn_order.clear()
	elif(character_list.has(player_character) && character_list.size() == 1):
		encounter_state = Encounter.END
		print("Les ennemies sont morts")
		#get_tree().paused = true
		#win_ui.visible = true
		Game_Manager.Next_Level()
		character_list.clear()
		turn_order.clear()
		
		
func end_turn(actor):
	if actor != current_character:
		print("Ignoring turn end from", actor.name)
		return
	await pv_verif()  # Remove characters with 0 HP
	
	
	print("Character status end turn")
	for entity in character_list:
		print("Character HP states:", entity.stats.current_hp )
	
	# Ensure current_character is still valid in turn_order
	if current_character and turn_order.has(current_character):
		turn_order.erase(current_character)

	if turn_order.is_empty():
		print("No more characters left. Starting a new round...")
		print("EMITTING POISON TICK")
		Events.poison_tick_trigger.emit()
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
		if not is_instance_valid(entity):
			continue
		if entity.stats.current_hp > 0:
			turn_order.append(entity)

	if turn_order.is_empty():
		print("All characters are down. Game Over!")
		game_over = true
		return
	
	connectionVerif()# Ensure each character has signals connected
	start_turn()

func start_turn():
	print("Current turn order before action: ", turn_order)
	if turn_order.is_empty():
		print("Turn order is empty, starting new round")
		Events.poison_tick_trigger.emit()
		start_round()  # Start a new round if no turns are left
		return

	current_character = turn_order.pop_front()
	print(current_character.name, " is now acting.")
	current_character.start_turn()
	
