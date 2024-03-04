extends CharacterBody3D

const SPEED = 5.0
const HORIZONTAL_ACCELERATION = 3
const ROTATION_SPEED = 2
const CAMERA_ROTATION_SPEED = .0015
const WAVE_SPEED=5
const WAVE_HEIGHT=0.5
const SEA_LEVEL=1

@onready var camera = $CameraPivot
@onready var player = $PlayerPivot

func _ready():
	Input.mouse_mode=Input.MOUSE_MODE_CAPTURED
	$PlayerPivot/bin/AnimationPlayer.play('roll')

func _unhandled_input(_event):
	if _event is InputEventMouseMotion and Input.mouse_mode==Input.MOUSE_MODE_CAPTURED:
		camera.rotate_y(-_event.relative.x * CAMERA_ROTATION_SPEED)
		#TODO clip the camera rotation to the player rotation

func _unhandled_key_input(_event):
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.mouse_mode==Input.MOUSE_MODE_CAPTURED: 
			Input.mouse_mode=Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode=Input.MOUSE_MODE_CAPTURED

func _physics_process(delta):
	# Add the waves
	position.y = cos(Time.get_unix_time_from_system() * WAVE_SPEED) * WAVE_HEIGHT + SEA_LEVEL

	# Get the input direction and handle the movement/deceleration.
	var input_dir = Vector3.ZERO
	input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	input_dir=input_dir.normalized()
	
	## Get the forward speed (the y direction of the input)
	## This is controlled with the w-s up-down
	var direction = (transform.basis * Vector3(0, 0, input_dir.y)).rotated(Vector3(0, 1, 0), player.rotation.y)
	direction *= SPEED
	velocity.x = move_toward(velocity.x,direction.x, HORIZONTAL_ACCELERATION * delta)
	velocity.z = move_toward(velocity.z,direction.z, HORIZONTAL_ACCELERATION * delta)
	
	## Get rotation (the x direction of the input)
	## This is controlled with a-d left-right
	## We apply it to the player AND the camera so the camera follows the player
	player.rotation.y -= input_dir.x * delta * ROTATION_SPEED
	camera.rotation.y -= input_dir.x * delta * ROTATION_SPEED
	move_and_slide()
	force_update_transform()
