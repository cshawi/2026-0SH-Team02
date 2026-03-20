extends Effect

class_name StatusEffect

enum StackType {
	NONE,
	STACK,
	REFRESH,
	REPLACE
}

var stack_type = StackType.STACK

var duration = 3

func on_apply(target):
	pass

func on_turn_start(target):
	pass

func on_turn_end(target):
	duration -= 1

func is_finished():
	return duration <= 0
