extends CharacterBody3D


const SPEED = 4.5
const ACCEL = 10
const JUMP_VELOCITY = 4.5
var player

@onready var nav: NavigationAgent3D = $NavigationAgent3D
#@onready var player: CharacterBody3D = $Player

func _ready():
	player = get_tree().get_root().get_node("World").get_node("Player")
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	
	var direction = Vector3()
	if player:
		nav.target_position = player.get_position()
	#nav.target_position = Vector3.ZERO
#
	direction = nav.get_next_path_position() - global_position
	direction = direction.normalized()

	velocity = velocity.lerp(direction * SPEED, ACCEL * delta)

	move_and_slide()
