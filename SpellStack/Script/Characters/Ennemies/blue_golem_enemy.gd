#extends Entity
extends Ennemi
# class parent qui fera juste le tour des actions principales
#chaque ennemi va heriter de Ennemi
class_name BlueGolem

func _ready() -> void:
	stats_path = "res://Resources/Stats/BlueGolem.tres"
	stats = load(stats_path).duplicate(true)
	if stats == null:
		print("stats null chemin invalid pour " , self )
	super._ready()

func _attack():
	$Blue_Golem.play("attack")
	await $Blue_Golem.animation_looped
	$Blue_Golem.play("idle")
	
func _on_death():
	$Blue_Golem.play("death")
	await $Blue_Golem.animation_looped
