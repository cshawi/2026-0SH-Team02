extends TextureProgressBar

class_name playerHpBar

@onready var damageBar = $DamageBar
@onready var timer =$Timer
@onready var label = $Label

func _ready():
	Events.player_health_changed.connect(_on_health_changed)

func _init() -> void:
	pass


func _on_health_changed(current, max):
	
	if(value > current ):
		timer.start()
	
	max_value = max
	value = current
	label.text = "%d/%d" % [value,max_value]


func _on_timer_timeout() -> void:
	damageBar.value = value
	
