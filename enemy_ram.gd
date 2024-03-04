extends CharacterBody3D


const SPEED = 2.5
const PUSH_VELOCITY = 10
const ACCEL = 10
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
		
		# Rotation: Make sure the boat is pointing at the player at all times
		var angle = atan2(position.x - player_pos.x, position.z - player_pos.z)
		rotation = Vector3(0, angle, 0)

	direction = nav.get_next_path_position() - global_position
	direction = direction.normalized()

	velocity = velocity.lerp(direction * SPEED, ACCEL * delta)
	
	var collision = move_and_collide(velocity * delta)
	if collision:
		var collider = collision.get_collider()
		if collider == player:
			var player_target_speed = direction * PUSH_VELOCITY
			player.velocity = player_target_speed

