extends Node2D

class_name Card

signal hovered
signal hovered_off
signal card_selected(card)

var hand_position
var action : Action
@onready var cost :Label = $Control/Cost
@onready var des :Label = $Control/Description
@onready var nom :Label = $Control/Nom

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_parent().connect_card_signals(self)
	print($"Control/Nom")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_mouse_entered() -> void:
	emit_signal("hovered",self)
	print(self.name)


func _on_area_2d_mouse_exited() -> void:
	emit_signal("hovered_off",self)
	
func play(player:Entity, target : Entity) -> void:
	action.execute(player,target)
	print("jessais de play mon action ")
	
	
func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		emit_signal("card_selected", self)
		
func initData(card_data):
	
	self.get_node("CardImage").texture = card_data.texture
	self.action = card_data.action.duplicate() 
	self.name = card_data.name
	des.text = card_data.description
	nom.text = card_data.name
	cost.text = str(card_data.cost)
	
