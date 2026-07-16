extends Resource
class_name Action

@export var name : String
@export var effects : Array[Effect]
@export var success_rate: bool  # Probability of success (0.0 to 1.0)


func execute(user, target):
	for effect in effects:
		effect.apply(user, target)

func is_action_successful(_action: Action, target: Entity) -> bool:
	# Example logic for determining action success
	if target.stats.current_hp <= 0:
		return false  # Can't succeed if the target is down
	
	return true
