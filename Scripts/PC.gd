extends CharacterBody3D


const SPEED = 30
const JUMP_VELOCITY = 80

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var cam = $Camera3D
@onready var marker = $followDAD/Marker3D

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta *12
	
	$followDAD.transform = $followDAD.transform.rotated(Vector3(0,1,0), (.07*Input.get_last_mouse_velocity().normalized().x))
	
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
#		print(Input.get_last_mouse_velocity())
#	if Input.is_action_just_pressed("ui_accept"):
#		pass
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_down", "ui_up", "ui_left", "ui_right", )
	var direction = (transform.basis * Vector3(input_dir.x, input_dir.y, 0)).normalized()
#	print(input_dir)
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		transform = transform.rotated_local(Vector3(0,1,0), deg_to_rad(direction.y * -2))
#		rotate_y(deg_to_rad(input_dir.y * -2))
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	move_and_slide()
