extends Effect
class_name Poison

func apply(user, target: Entity):
	print(target, "is getting poisoned by", user)
	target.is_poisoned = true
	target.poison_stacks = 2
	
