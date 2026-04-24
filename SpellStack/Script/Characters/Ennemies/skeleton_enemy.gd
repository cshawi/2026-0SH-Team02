#extends Entity
extends Ennemi
# class parent qui fera juste le tour des actions principales
#chaque ennemi va heriter de Ennemi
class_name Skeleton

func _ready() -> void:
	stats_path = "res://Resources/Stats/skeleton.tres"
	stats = load(stats_path).duplicate(true)
	if stats == null:
		print("stats null chemin invalid pour "  , self )
	super._ready()

func _attack():
	$Skeleton.play("attack")
	await $Skeleton.animation_looped
	$Skeleton.play("idle")

func _on_death():
	$Skeleton.play("die")
	SoundManager.dead_skeleton()
	await $Skeleton.animation_looped
	
