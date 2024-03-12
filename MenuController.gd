extends Control

@onready var resumeButton = $VBoxContainer/Buttons/ResumeButton
@onready var exitButton = $VBoxContainer/Buttons/ExitButton
# Called when the node enters the scene tree for the first time.
func _ready():
	resumeButton.connect("pressed", _on_resume_button_pressed)
	exitButton.connect("pressed", _on_exit_button_pressed)

func _on_resume_button_pressed():
	resumeGame()

func _on_exit_button_pressed():
	get_tree().quit()

func pauseGame():
	get_tree().paused = true
	Input.mouse_mode=Input.MOUSE_MODE_VISIBLE
	self.visible = true

func resumeGame():
	get_tree().paused = false
	Input.mouse_mode=Input.MOUSE_MODE_CAPTURED
	self.visible = false

func _unhandled_key_input(_event):
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.mouse_mode==Input.MOUSE_MODE_CAPTURED: 
			pauseGame()
		else:
			resumeGame()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
