extends Node2D

const CARD_SCENE_PATH = "res://Scenes/Cards/Card.tscn"
const CARD_DRAW_SPEED = 0.3

var player_deck = ["Fireball","AcidSpray","Splash","Zap" ]
var card_database_reference = preload("res://Script/CardDatabase.gd")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_deck.shuffle()
	$RichTextLabel.text = str(player_deck.size())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func draw_card():
	var card_drawn_name = player_deck[0]
	player_deck.erase(card_drawn_name)
	
	#if last card drawn disable deck 
	if player_deck.size() == 0 :
		$Area2D/CollisionShape2D.disabled = true 
		$Sprite2D.visible = false
		$RichTextLabel.visible = false
		
	$RichTextLabel.text = str(player_deck.size())
	var card_scene = preload(CARD_SCENE_PATH)
	var new_card = card_scene.instantiate()
	var card_image_path = str("res://assets/Sprites/Cards/"+ card_drawn_name +"Card.png")
	new_card.get_node("CardImage").texture = load(card_image_path)
	$"../CardManager".add_child(new_card)
	new_card.name = "Card"
	$"../PlayerHand".add_card_to_hand(new_card,CARD_DRAW_SPEED)
