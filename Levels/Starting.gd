extends Node3D

@onready var cam = $statCam
# Called when the node enters the scene tree for the first time.
func _ready():
	cam.make_current()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	transform = transform.rotated_local(Vector3(0,1,0), deg_to_rad(0.25))
	cam.look_at(self.global_position)
	if Input.is_action_just_pressed("start"):
		queue_free()
