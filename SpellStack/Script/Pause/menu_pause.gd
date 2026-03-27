extends Control
@onready var quit: Button = $QuitButtonContainer/Quit
@onready var resume: Button = $ResumeButtonContainer/Resume
@onready var Main_menu = $"../MainMenu"

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	quit.pressed.connect(_on_quit_pressed)
	resume.pressed.connect(_on_resume_pressed)
	visible = false

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel") and !Main_menu.visible: # ESC par défaut
		toggle_pause()

func toggle_pause():
	get_tree().paused = !get_tree().paused
	visible = get_tree().paused

func _on_quit_pressed():
	get_tree().quit()

func _on_resume_pressed():
	get_tree().paused = false
	visible = false
