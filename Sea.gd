extends CSGBox3D
@export var WAVE_SPEED=5
@export var WAVE_HEIGHT=0.5
@export var SEA_LEVEL=1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_wave_height():
	return cos(Time.get_unix_time_from_system() * WAVE_SPEED) * WAVE_HEIGHT + SEA_LEVEL
