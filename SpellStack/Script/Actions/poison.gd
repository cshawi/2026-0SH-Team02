extends Effect
class_name Poison

func apply(user, target: Entity):
	print(target, "is getting poisoned by", user)
	target.stats.poison = true
	target.stats.poison_stacks = 2
	
