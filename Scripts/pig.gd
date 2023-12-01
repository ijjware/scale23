extends CharacterBody3D
var isSwallowed = false
@export var speed = 50
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var start_position = global_position
@onready var target = global_position
var home = false

func _ready():
	updated_target()
	
func _physics_process(delta):
	if abs(global_position.x - target.x) < 5 and abs(global_position.z - target.z) < 5:
		updated_target()
	self.velocity = (target - global_position).normalized() * speed
	if not is_on_floor():
		velocity.y -= gravity * delta * 10
	look_at(target)
	if !home: move_and_slide()
	
func updated_target():
	var target_vector = Vector3(randf_range(-50, 50), 0, randf_range(-50, 50))
	target = start_position + target_vector
