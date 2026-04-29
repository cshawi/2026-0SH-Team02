extends Node2D

class_name Deck

const CARD_SCENE_PATH = "res://Scenes/Cards/Card.tscn"
const CARD_DRAW_SPEED = 0.1
const DECK_SIZE =2

#ici mettre action + modif references 
var player_starting_deck : Array = ["fireball","waterball","arcana","poisonspray"] 
var current_deck : Array =[]
#var player_deck : Array = ["Fireball","AcidSpray","Splash","Zap" ]
var player_deck : Array = [] #get selon les names dans le database
var discard_pile : Array = []
var card_database_reference = preload("res://Script/Cards/CardDatabase.gd")

@onready var numberOfCardLabel  = $RichTextLabel
@onready var deckImage = $DeckImage
@onready var collision = $Area2D/CollisionShape2D

@onready var cardManager: CardManager = $"../CardManager"
@onready var playerHand: PlayerHand = $"../PlayerHand"
@onready var cardDatabase: CardDatabase = $"../CardDatabase"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_deck.shuffle()
	numberOfCardLabel.text = str(player_deck.size())
	print(get_tree().get_current_scene().get_tree_string())
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func draw_card():
		
		var card_drawn_name = player_deck[0]
		player_deck.erase(card_drawn_name)
		
		#if last card drawn disable deck 
		if player_deck.size() == 0 :
			collision.disabled = true 
			deckImage.visible = false
			numberOfCardLabel.visible = false
			
			
		numberOfCardLabel.text = str(player_deck.size())
		var card_scene = preload(CARD_SCENE_PATH)
		var card_data = cardDatabase.get_card(card_drawn_name)
		var new_card = card_scene.instantiate()
		
		cardManager.add_child(new_card)
		new_card.initData(card_data)
		
		playerHand.add_card_to_hand(new_card,CARD_DRAW_SPEED)
		
		
		
func delete_hand():
	for card in cardManager.get_children():
		if card is Card:
			card.queue_free()
	
	playerHand.player_hand.clear()
		
		
func refill_card():
	player_deck = player_starting_deck.duplicate(true)
	
func draw_pile():
	player_deck.shuffle()
	for i in range(DECK_SIZE):
		draw_card()
	
	
	
