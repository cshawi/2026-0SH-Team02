#extends Entity
extends Ennemi
# class parent qui fera juste le tour des actions principales
#chaque ennemi va heriter de Ennemi
class_name OrangeGolem

func _ready() -> void:
	stats_path = "res://Resources/Stats/OrangeGolam.tres"
	stats = load(stats_path).duplicate(true)
	if stats == null:
		print("stats null chemin invalid pour "  , self )
	super._ready()

func _attack():
	$Orange_Golem.play("attack")
	await $Orange_Golem.animation_looped
	$Orange_Golem.play("idle")

func _on_death():
	$Orange_Golem.play("die")
	await $Orange_Golem.animation_looped
