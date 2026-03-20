extends Control

class_name Player_actions

signal action_selected(action)

@onready var container = $Layout

func show_actions(actions):

	for child in container.get_children():
		child.queue_free()

	for action in actions:
		var button = Button.new()
		button.text = action.name

		button.pressed.connect(
			func():
			action_selected.emit(action)
		)

		container.add_child(button)
