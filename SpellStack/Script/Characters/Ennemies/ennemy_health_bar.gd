extends TextureProgressBar

@onready var label = $Label

func update(health, max_health):
	self.max_value = max_health
	self.value = health
	label.text = "%d/%d" % [health,max_health]
