extends Entity

class_name Player

@export var stats : Player_stats
@onready var action_ui = $"../../UI/PlayerAction"
@export var target_manager : TargetManager # selection de l'enemy en mode selection

var selected_action : Action = null # Pour le mode selection de cible

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("player_side")
	if stats == null:
		print("stats null chemin invalid")

	if action_ui ==null :
		print("chemin du ui_playerAction est null")
		
	action_ui.action_selected.connect(_on_action_selected)
	action_ui.show_actions(actions)
	action_ui.show()
	
	target_manager.target_selected.connect(_on_target_selected)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_action_selected(action):
	if(turn_state== Turn_state.ACTING):
		selected_action = action
		target_manager.start_selection()
		print("Action choisie :", action.name)
	
func _on_target_selected(enemy):
	if(turn_state== Turn_state.ACTING):
		perform_action(selected_action, enemy)
		selected_action = null
		
		
func start_turn():
	super.start_turn()
	selected_action = null
