extends EntityBaseStats

class_name Player_stats

func _init():
	max_hp =100
	current_hp = max_hp
	hp_regen =0
	life_steal = 0
	armor =0
	penetration =0

@export var deck_size: int = 4
@export var energy: int = 2;
@export var luck: int = 0
