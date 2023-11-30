#extends "res://Scripts/noms.gd"
extends Node3D


var isSwallowed = false
@onready var agent = $NavigationAgent3D
@export var speed = 1.0

var target: Vector3
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
#	area.connect("body_exited", _on_area_3d_body_exited)
#	area.connect("body_entered", _on_area_3d_body_entered)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
#	if Input.is_action_just_pressed("eat") and nommable:
		#catch signal at scene root
#		emit_signal("nom", self)
# increment pathfollow progress

func nom():
	pass

func _physics_process(delta):
	#self.look_at(target)
	#self.rotation.x = 0
	#self.rotation.y = 0
	pass
	
func update_target_pos():
	pass
	

func swallowed():
	isSwallowed = true # don't walk 
#	area.monitorable = false
#	area.monitorable = false
	self.visible = false 

func spit_up():
#	area.monitorable = true
#	area.monitorable = true
	await get_tree().create_timer(1).timeout
	isSwallowed = false #right self, resume walk
	self.visible = true
