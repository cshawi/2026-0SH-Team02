extends Entity

# class parent qui fera juste le tour des actions principales
#chaque ennemi va heriter de Ennemi
class_name Ennemi
@export var target_manager : TargetManager

var stats_path: String = ""
@export var stats : Basic_enemy_stats
@onready var click_area = $Area2D

@onready var health_bar = preload("res://Scenes/ennemy_health_bar.tscn").instantiate()
var max_health : int
var health : int

signal clicked(enemy)

func _ready() -> void:
	add_to_group("enemies")
	print("enemy ready")
	click_area.clicked.connect(_on_clicked)
	_create_health_bar()

func _create_health_bar():
	add_child(health_bar)
	health_bar.position = Vector2(-25, -30)
	
	max_health = stats.max_hp
	health = stats.current_hp
	
	health_bar.update(health, max_health)

func start_turn():
	if(turn_state ==Turn_state.WAITING):
		turn_state = Turn_state.ACTING
		choose_action()

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
	
	perform_action(action, target) 
	_attack()
	 # This should also be tracked for successes or failures.

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

func _attack():
	#fonction virtuelle qui sert de template à chaque ennemi pour jouer son animation d'attaque
	pass

func _on_death():
	#fonction virtuelle qui sert de template à chaque ennemi pour jouer son animation de mort
	pass

func update_hp_bar(damage:int):
	health -= damage
	health_bar.update(health, max_health)

func _take_poison_virtual():
	if(self.stats.current_hp <= 10 && self.stats.current_hp !=1):
		var remaining_damage = self.stats.current_hp - 1
		self.stats.take_damage(remaining_damage) 
		update_hp_bar(remaining_damage)
	elif(self.stats.current_hp == 1):
		pass
	else:
		self.stats.take_damage(10) 
		update_hp_bar(10)
