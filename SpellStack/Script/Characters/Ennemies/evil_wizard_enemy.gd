#extends Entity
extends Ennemi
# class parent qui fera juste le tour des actions principales
#chaque ennemi va heriter de Ennemi
class_name Evil_wizard

func _ready() -> void:
	stats_path = "res://Resources/Stats/Evil_wizard.tres"
	stats = load(stats_path).duplicate(true)
	if stats == null:
		print("stats null chemin invalid pour "  , self )
	super._ready()

func _attack():
	$wizard.play("new_animation")
	await $wizard.animation_looped
	$wizard.play("idle")

func _on_death():
	$wizard.play("die")
	await $wizard.animation_looped
