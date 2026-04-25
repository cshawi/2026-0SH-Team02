extends Node
class_name CardDatabase

var cards = {
	"fireball": preload("res://Resources/actions_cards/Cards/fireball.tres"),
	"waterball": preload("res://Resources/actions_cards/Cards/waterball.tres"),
	"arcana": preload("res://Resources/actions_cards/Cards/arcaneSpell.tres")
}
#retourne la carte selon le nom
func get_card(card_name : String) -> CardData:
	return cards.get(card_name)
