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
		
func _process(_delta: float) -> void:
	if game_over:
		return
	
	match encounter_state:	
		Encounter.NONE:
			pass
			
		Encounter.START:
			enter_encounter();
			
		Encounter.IN_ENCOUNTER:
			pass
		Encounter.END:
			pass

func connectionVerif():
	for actor in turn_order:
		if !actor.turn_finished.is_connected(end_turn):
			actor.turn_finished.connect(end_turn)

func start_encounter(level):
	enemies_character.clear()
	enemies.clear()
	character_list.clear()
	turn_order.clear()
	
	for child in level.get_children():
		if child is Ennemi:
			enemies_character.append(child)

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
	for enemy in enemies_character:
		enemies.append(enemy) 
	
# check les pv
func pv_verif(): 
	var to_remove = []
	for entity in character_list:
		if not is_instance_valid(entity):
			continue

		if entity.stats.current_hp <= 0:
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
		Game_Manager.player_death()
		character_list.clear()
		turn_order.clear()
	elif(character_list.has(player_character) && character_list.size() == 1):
		encounter_state = Encounter.END
		Game_Manager.Next_Level()
		character_list.clear()
		turn_order.clear()
		
		
func end_turn(actor):
	if actor != current_character:
		print("Ignoring turn end from", actor.name)
		return
	await pv_verif()  # Remove characters with 0 HP
	
	# Ensure current_character is still valid in turn_order
	if current_character and turn_order.has(current_character):
		turn_order.erase(current_character)

	if turn_order.is_empty():
		Events.poison_tick_trigger.emit()
		start_round()  # Call to start the next round
	else:
		if turn_order.size() > 0:
			start_turn()  # Continue to the next character's turn

func start_round():
	turn_order.clear()

	# Populate turn_order with alive characters
	for entity in character_list:
		if not is_instance_valid(entity):
			continue
		if entity.stats.current_hp > 0:
			turn_order.append(entity)

	if turn_order.is_empty():
		game_over = true
		return
	
	connectionVerif()# Ensure each character has signals connected
	start_turn()

func start_turn():
	if turn_order.is_empty():
		Events.poison_tick_trigger.emit()
		start_round()  # Start a new round if no turns are left
		return

	current_character = turn_order.pop_front()
	current_character.start_turn()
	
