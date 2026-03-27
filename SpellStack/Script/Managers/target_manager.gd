extends Node

class_name TargetManager

signal target_selected(target)

var selecting = false

func start_selection():
	var enemies = get_tree().get_nodes_in_group("enemies")
	print(enemies)
	
	for enemy in enemies:
		if not enemy.clicked.is_connected(_on_enemy_clicked):
			enemy.clicked.connect(_on_enemy_clicked)
	selecting = true;
		
		
func _on_enemy_clicked(enemy): # reagit pas
	if selecting == false:
		return
		print(enemy)
	
	selecting = false
	target_selected.emit(enemy)

func select_target(enemy):
	target_selected.emit(enemy)
