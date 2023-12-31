extends CharacterBody3D

#signal spit(thing)
const SPEED = 65
const JUMP_VELOCITY = 50
const SPIT_SPEED = 120
const SPIT_CHAR = 250
var airJumps = 1
var stomachSize = 1
var speedReduction = 1.5
var jumpReduction = 5
var spd = 2
var can_eat = []
var off = false
var walktime = 0
@export var ball_grow_factor = .3
@onready var ball = $wholeguy/Armature_001/Skeleton3D/BoneAttachment3D/CharacterBody3D/CollisionShape3D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var cam = $Camera3D
@onready var hideout = $behindCam
@onready var front = $frontPC
@onready var stomachs = Array()

func _physics_process(delta):
	# Add the gravity.
	if off:
		return
	if not is_on_floor():
		velocity.y -= gravity * delta *1
	else: airJumps = 1
#	$followDAD.transform = $followDAD.transform.rotated(Vector3(0,1,0), (.07*Input.get_last_mouse_velocity().normalized().x))
	if Input.is_action_just_pressed("spit") and !stomachs.is_empty():
		spit()
		$spitter.play()
	if Input.is_action_just_pressed("eat") and !can_eat.is_empty() and stomachs.size() < stomachSize:
		add_stomach(can_eat.pop_front())
	# Handle Jump.
	if Input.is_action_just_pressed("jump") and (is_on_floor() or airJumps>0):
		$jumper.play()
		velocity.y = JUMP_VELOCITY - (stomachs.size() * jumpReduction)
		if !is_on_floor(): airJumps -= 1
#		print(Input.get_last_mouse_velocity())
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("backward", "forward", "turn_left", "turn_right", )
	var direction = (transform.basis * Vector3(input_dir.x, input_dir.y, 0)).normalized()
#	print(input_dir)
	if direction:
		walkwav()
		spd = move_toward(spd, SPEED, .5)
		velocity.x = direction.x * (spd - (stomachs.size()*speedReduction))
		velocity.z = direction.z * (spd - (stomachs.size()*speedReduction))
		transform = transform.rotated_local(Vector3(0,1,0), deg_to_rad(direction.y * -2))
	else:
		spd = move_toward(spd, 2, .1)
		velocity.x = move_toward(velocity.x, 0, (spd/10 + (stomachs.size()*speedReduction)))
		velocity.z = move_toward(velocity.z, 0, (spd/10 + (stomachs.size()*speedReduction)))
	
	var current_animation = $wholeguy/AnimationTree.get('parameters/playback').get_current_node()

	$wholeguy/AnimationTree.set("parameters/conditions/idle", input_dir == Vector2.ZERO)
	$wholeguy/AnimationTree.set("parameters/conditions/walk", input_dir != Vector2.ZERO)
	$wholeguy/AnimationTree.set('parameters/conditions/ballswing', Input.is_action_pressed('ballspin'))
	$wholeguy/AnimationTree.set('parameters/conditions/onFloor', is_on_floor())

	if is_on_floor() == false and current_animation != "FallingLoop" and current_animation != "BallSwing":
		$wholeguy/AnimationTree["parameters/playback"].travel("FallingStart")
	move_and_slide()

func spit():
	var thing = stomachs.pop_front()
	thing.global_position = front.global_position
#	print(front.global_position)
	var eh = front.global_position.direction_to($aim.global_position)
	if eh.y < 0: 
		eh.y = 1
	if thing is CharacterBody3D:
		thing.velocity = eh
		thing.velocity.x *= SPIT_CHAR
		thing.velocity.z *= SPIT_CHAR
	if thing is RigidBody3D:
		thing.freeze = false
		thing.apply_impulse(eh * SPIT_SPEED)
	thing.visible = true
	thing.get_node("CollisionShape3D").disabled = false
	ball.scale.x -= ball_grow_factor
	ball.scale.y -= ball_grow_factor
	ball.scale.z -= ball_grow_factor

func add_stomach(thing):
	stomachs.append(thing)
	thing.visible = false
	if thing is RigidBody3D:
		thing.freeze = true
	thing.get_node("CollisionShape3D").disabled = true
	ball.scale.x += ball_grow_factor
	ball.scale.y += ball_grow_factor
	ball.scale.z += ball_grow_factor
	#ball.scale(Vector3(4, 4, 4))

func eat_cake():
	$caker.play()
	stomachSize += 1

func victory():
	$wholeguy/AnimationTree["parameters/playback"].travel("VictoryPose")

func walkwav():
	walktime +=1
	if walktime >= 30 && is_on_floor(): 
		$stepper.play(0.0)
		walktime = 0

func _on_interact_area_body_entered(body):
	if body.is_in_group("noms"):
		can_eat.append(body)

func _on_interact_area_body_exited(body):
	if body.is_in_group("noms"):
		can_eat.erase(body)

func _on_animation_tree_animation_started(anim_name):
	if anim_name == "BallSwing":
		$slapper.play()
		pass
	pass # Replace with function body.
