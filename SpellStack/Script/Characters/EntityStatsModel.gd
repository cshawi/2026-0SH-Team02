extends Resource

class_name EntityBaseStats

@export_group("Other")
@export var current_hp: float = 20.0

@export_group("Base Stats")
@export var max_hp: float = 20.0
@export var hp_regen: float = 0.0
@export var life_steal: float =0.0
@export var armor: int = 0
@export var penetration: int = 0

func take_damage(amount):
	current_hp -= clamp(amount,0,max_hp)
