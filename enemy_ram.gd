extends CharacterBody3D


const SPEED = 2.5
const ACCEL = 10
const JUMP_VELOCITY = 4.5
var player

@onready var nav: NavigationAgent3D = $NavigationAgent3D


func _ready():
	player = get_tree().get_root().get_node("World").get_node("Player")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	
	var direction = Vector3()
	if player:
		var player_pos = player.get_position()
		nav.target_position = player_pos

	direction = nav.get_next_path_position() - global_position
	direction = direction.normalized()

	velocity = velocity.lerp(direction * SPEED, ACCEL * delta)

	var collision = move_and_collide(velocity * delta)
	if collision:
		var collider = collision.get_collider()
		if collider == player:
			player.velocity.x = velocity.x
			player.velocity.y = velocity.y

