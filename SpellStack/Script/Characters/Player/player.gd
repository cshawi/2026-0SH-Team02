extends Entity

class_name Player

#@export var stats : Player_stats
var stats_path: String = "res://Resources/Stats/player_stats.tres"
var stats: Player_stats

@export var action_ui : Control
@export var target_manager : TargetManager # selection de l'enemy en mode selection
var selected_action : Action = null # Pour le mode selection de cible
var selected_card : Card =null

@onready var cardManager : CardManager = $"../CardBook/CardManager"
@onready var playerDeck : Deck = $"../CardBook/Deck"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	add_to_group("player_side")
	stats = load(stats_path).duplicate(true)
	if stats == null:
		print("stats null chemin invalid")

	if action_ui ==null :
		print("chemin du ui_playerAction est null")
		
	if cardManager ==null :
		print("je connais pas card manager")
		
	#action_ui.action_selected.connect(_on_action_selected)
	#action_ui.show_actions(actions)
	cardManager.connect("card_selected", _on_action_selected)
	cardManager.connect("card_dropped_on_enemy", _on_card_dropped)

	target_manager.target_selected.connect(_on_target_selected)
	emit_health()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func _on_action_selected(action):
	if(turn_state== Turn_state.ACTING):
		#selected_action = action
		selected_card = action
		target_manager.start_selection()
		print("Action choisie :", action.name)
	
func _on_target_selected(enemy):
	if(turn_state== Turn_state.ACTING):
		perform_action(selected_card, enemy)
		play_attack()
		#selected_action = null
		selected_card =null
		#
#func start_turn():
	#super.start_turn()
	#selected_card =null
	#print("DECK SIZE Avant REFILL:", playerDeck.player_deck.size())
	#playerDeck.refill_card()
	#print("DECK SIZE Avant DRAW:", playerDeck.player_deck.size())
	#playerDeck.draw_pile()
	#print("DECK SIZE Apres DRAW:", playerDeck.player_deck.size())
	#
	#
	##selected_action = null
	#
#func end_turn(): 
	#super.end_turn()
	#playerDeck.delete_hand()
func start_turn():
	print("=== PLAYER START_TURN APPELÉ ===")
	selected_card = null
	playerDeck.refill_card()
	playerDeck.draw_pile()
	super.start_turn()


func end_turn():
	print("Hand avant delete:", playerDeck.playerHand.player_hand.size())
	playerDeck.delete_hand()
	super.end_turn()
	print("Hand après delete:", playerDeck.playerHand.player_hand.size())
	
	
func emit_health():
	Events.emit_signal("player_health_changed", stats.current_hp, stats.max_hp)
	
func play_attack():
	$player.play("attack")
	await $player.animation_looped
	$player.play("idle")
	
func _on_card_dropped(card, enemy):
	selected_card = card
	_on_target_selected(enemy)
	
