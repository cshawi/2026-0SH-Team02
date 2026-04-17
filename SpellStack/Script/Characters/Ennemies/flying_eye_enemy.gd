#extends Entity
extends Ennemi
# class parent qui fera juste le tour des actions principales
#chaque ennemi va heriter de Ennemi
class_name FlyingEye

func _ready() -> void:
	stats_path = "res://Resources/Stats/basic_ennemi.tres"
	stats = load(stats_path).duplicate(true)
	if stats == null:
		print("stats null chemin invalid pour "  , self )
	super._ready()

func _attack():
	$FlyingEye.play("attack")
	await $FlyingEye.animation_looped
	$FlyingEye.play("idle")

func _on_death():
	$FlyingEye.play("die")
	await $FlyingEye.animation_looped
