extends Node

@export var player_character : Player
@export var ennemi_character : Ennemi

var current_character : Object # a changer pour plus tard Celui qui a le tour

var turn_order : Array = [] #si ennemi est mort on sort de la liste sinon autres
var current_turn_index : int = 0 # 

var enemies : Array[Ennemi] = []
var game_over : bool = false

#fait le tour des etats dun encounter
enum Encounter { NONE, START, IN_ENCOUNTER ,END   } 


func _ready() -> void:
	if player_character != null:
		print("error player not found");
		
	#current_character.turn_finished.connect(next_turn)
func _process(delta: float) -> void:
	if game_over:
		return
	
	match Encounter:	
		Encounter.NONE:
			print("NONE");
		Encounter.START:
			print("START");
		Encounter.IN_ENCOUNTER:
			print("IN_ENCOUNTER");
		Encounter.END:
			print("END");	
		_:
			print("OUT OF THE ENUM OF ENCOUNTER");
			
			
func start_encounter(): # fait juste summon pour l'instant
	summonEncounter();
	start_round();
	for actor in turn_order:
		actor.turn_finished.connect(next_turn)
	
	
func summonEncounter():
	pass
	
func end_encounter():
	pass
	
	
func start_round():
		
	# rajoute le joueur en premier puis les ennemies sinnon fin 
	turn_order.append(player_character);
	current_character = player_character
		
	if enemies != []:
		for enemy in enemies:
			turn_order.append(enemy);
	else :
		print("Liste d'ennemie vide lors du debut de round"); 
		#end_encounter();
		
		
func next_turn ():
		
	if current_character != null:
		current_character.end_turn(); 
		# a rajouter quil sort de la liste de tour
		
		#changement de tour via la liste
		current_turn_index +=1;
		if current_turn_index > turn_order.size():
			start_round();
			current_turn_index =0
		else:
			current_character = turn_order[current_turn_index];
			
	
