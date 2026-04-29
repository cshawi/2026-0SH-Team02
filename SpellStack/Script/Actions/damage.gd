extends Effect
class_name DamageTest

@export var damage : int = 10

func apply(user, target):
	var armor = target.stats.armor
	var finalised_damage = damage - armor
	await target.stats.take_damage(finalised_damage) 
	if(target is Ennemi):
		target.update_hp_bar(finalised_damage)
	
