#extends Entity
extends Ennemi
# class parent qui fera juste le tour des actions principales
#chaque ennemi va heriter de Ennemi
class_name FlyingDemon

func _ready() -> void:
	stats_path = "res://Resources/Stats/basic_ennemi"
	stats = load(stats_path).duplicate(true)
	if stats == null:
		print("stats null chemin invalid pour "  , self )
	super._ready()

func _attack():
	$Flying_Demon.play("attack")
	await $Flying_Demon.animation_looped
	$Flying_Demon.play("idle")

func _on_death():
	$Flying_Demon.play("die")
	await $Flying_Demon.animation_looped
