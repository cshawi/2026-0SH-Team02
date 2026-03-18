extends Effect
class_name Heal

@export var amount : int = 10 # base sans modif

func apply(user, target): # mettre a user oups 
	user.stats.current_hp += amount
	if user.stats.current_hp > user.stats.max_hp :
		user.stats.current_hp =user.stats.max_hp
