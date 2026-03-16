extends Effect
class_name Heal

@export var amount : int = 10 # base sans modif

func apply(user, target): # mettre a user oups 
	target.stats.current_hp += amount
	if target.stats.current_hp > target.stats.max_hp :
		target.stats.current_hp =target.stats.max_hp
