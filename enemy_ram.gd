extends CharacterBody3D


const SPEED = 5.0
const ACCEL = 10
const JUMP_VELOCITY = 4.5

@onready var nav: NavigationAgent3D = $NavigationAgent3D
#@onready var player: CharacterBody3D = $Player

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	
	var direction = Vector3()

	nav.target_position = Vector3(11.855, 2.0, -14.574)
	#nav.target_position = Vector3.ZERO
#
	direction = nav.get_next_path_position() - global_position
	direction = direction.normalized()

	velocity = velocity.lerp(direction * SPEED, ACCEL * delta)

	move_and_slide()
