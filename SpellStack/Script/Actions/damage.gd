extends Effect
class_name DamageTest

@export var damage : int = 10

func apply(user, target):
	await target.stats.take_damage(damage) 
	if(target is Ennemi):
		target.update_hp_bar(damage)
	
