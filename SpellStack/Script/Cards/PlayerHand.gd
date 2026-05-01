extends Node2D

class_name PlayerHand

const CARD_WIDTH = 100
const HAND_Y_POSITION = 200
const DEFAULT_CARD_SPEED = 0.01

var player_hand = []
var center_screen_x


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	center_screen_x = get_viewport().size.x/2

func add_card_to_hand(card, speed):
	
	if card not in player_hand:
		player_hand.append(card)
		update_hand_position(speed)
	else:
		animate_card_to_position(card,card.hand_position,speed)


func update_hand_position(speed):
	for i in range(player_hand.size()):
		var new_position = Vector2(calculate_card_position(i), HAND_Y_POSITION)
		var card = player_hand[i] 
		card.hand_position = new_position
		animate_card_to_position(card,new_position,speed)


func calculate_card_position(index):
	var total_width = (player_hand.size() - 1) * CARD_WIDTH 
	var x_offset = 400 + index * CARD_WIDTH - total_width / 2
	return x_offset


func animate_card_to_position(card,new_position,speed):
	var tween = get_tree().create_tween()
	tween.tween_property(card,"position",new_position,speed)
	
	
func remove_card_from_hand(card):
	if card in player_hand:
		player_hand.erase(card)
		update_hand_position(DEFAULT_CARD_SPEED)
		#card.queue_free() # ou discard
		
func delete_card_from_hand(card):
	if card in player_hand:
		player_hand.erase(card)
		#update_hand_position(DEFAULT_CARD_SPEED)
		card.queue_free()
