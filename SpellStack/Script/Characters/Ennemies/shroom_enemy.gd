#extends Entity
extends Ennemi
# class parent qui fera juste le tour des actions principales
#chaque ennemi va heriter de Ennemi
class_name Shroom

func _ready() -> void:
	stats_path = "res://Resources/Stats/death_ennemy.tres"
	stats = load(stats_path).duplicate(true)
	if stats == null:
		print("stats null chemin invalid pour "  , self )
	super._ready()

func _attack():
	$shroom.play("attack")
	await $shroom.animation_looped
	$shroom.play("idle")

func _on_death():
	$shroom.play("die")
	await $shroom.animation_looped
