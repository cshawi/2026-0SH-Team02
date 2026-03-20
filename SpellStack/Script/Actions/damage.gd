extends Effect
class_name DamageTest

@export var damage : int = 10

func apply(user, target):
	target.stats.current_hp -= damage
