extends StatusEffect
class_name PoisonEffect

var damage = 5

func on_turn_start(target):
	target.health -= damage
	print(target.name + " prend " + str(damage) + " dmg de poison")
