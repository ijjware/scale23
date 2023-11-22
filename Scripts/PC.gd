extends CharacterBody3D

#signal spit(thing)
const SPEED = 65
const JUMP_VELOCITY = 50
const SPIT_SPEED = 1
var airJumps = 1
var stomachSize = 1
var speedReduction = 1.5
var jumpReduction = 8
var spd = 2

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var cam = $Camera3D
@onready var hideout = $behindCam
@onready var front = $frontPC
@onready var stomachs = Array()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta *1
	else: airJumps = 1
#	$followDAD.transform = $followDAD.transform.rotated(Vector3(0,1,0), (.07*Input.get_last_mouse_velocity().normalized().x))
	if Input.is_action_just_pressed("spit") and !stomachs.is_empty():
		spit()
	# Handle Jump.
	if Input.is_action_just_pressed("jump") and (is_on_floor() or airJumps>0):
		velocity.y = JUMP_VELOCITY - (stomachs.size()*jumpReduction)
		if !is_on_floor(): airJumps -=1
#		print(Input.get_last_mouse_velocity())
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("backward", "forward", "turn_left", "turn_right", )
	var direction = (transform.basis * Vector3(input_dir.x, input_dir.y, 0)).normalized()
#	print(input_dir)
	if direction:
<<<<<<< Updated upstream
		velocity.x = direction.x * (SPEED - (stomachs.size() * speedReduction))
		velocity.z = direction.z * (SPEED - (stomachs.size() * speedReduction))
		transform = transform.rotated_local(Vector3(0,1,0), deg_to_rad(direction.y * -2))
	else:
		velocity.x = move_toward(velocity.x, 0, (SPEED - (stomachs.size() * speedReduction)))
		velocity.z = move_toward(velocity.z, 0, (SPEED - (stomachs.size() * speedReduction)))
		
	
	$wholeguy/AnimationTree.set("parameters/conditions/idle", input_dir == Vector2.ZERO)
	$wholeguy/AnimationTree.set("parameters/conditions/walk", input_dir != Vector2.ZERO)
	$wholeguy/AnimationTree.set('parameters/conditions/ballswing', Input.is_action_pressed('ballspin'))
=======
		spd = move_toward(spd, SPEED, .5)
		velocity.x = direction.x * (spd - (stomachs.size()*speedReduction))
		velocity.z = direction.z * (spd - (stomachs.size()*speedReduction))
		transform = transform.rotated_local(Vector3(0,1,0), deg_to_rad(direction.y * -2))
	else:
		spd = move_toward(spd, 2, .1)
		velocity.x = move_toward(velocity.x, 0, (spd/10 + (stomachs.size()*speedReduction)))
		velocity.z = move_toward(velocity.z, 0, (spd/10 + (stomachs.size()*speedReduction)))
>>>>>>> Stashed changes
	move_and_slide()

func spit():
	var thing = stomachs.pop_front()
	thing.position = front.global_position
#	var eh = front.global_position.direction_to($aim.global_position)
	var eh = self.velocity
	if eh.y < 0: eh.y = 1
#	print(eh)
	thing.spit_up()         
	thing.apply_central_impulse(Vector3(1,5,1)*eh *SPIT_SPEED)

func add_stomach():
	stomachSize +=1
	print("stummy")
