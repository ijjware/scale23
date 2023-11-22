extends "res://Scripts/noms.gd"

@onready var path = $".."
var isSwallowed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	area.connect("body_exited", _on_area_3d_body_exited)
	area.connect("body_entered", _on_area_3d_body_entered)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("eat") and nommable:
		#catch signal at scene root
		emit_signal("nom", self)
# increment pathfollow progress
	if !isSwallowed: path.progress += .1

func swallowed():
	isSwallowed = true
	area.monitorable = false
	area.monitorable = false
	self.visible = false 

func spit_up():
	area.monitorable = true
	area.monitorable = true
	await get_tree().create_timer(1).timeout
#	$"../..".global_position
#	isSwallowed = false
	self.visible = true
