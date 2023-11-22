extends Node

signal nom(node)
var nommable = false
@onready var area = $Area3D

func _ready():
	self.mass = 1
	area.connect("body_exited", _on_area_3d_body_exited)
	area.connect("body_entered", _on_area_3d_body_entered)

func _process(delta):
	if Input.is_action_just_pressed("eat") and nommable:
		#catch signal at scene root
		emit_signal("nom", self)

func _on_area_3d_body_entered(body):
	if body.name == "PC":
		nommable = true
#		print (body.name + "in" + name)

func _on_area_3d_body_exited(body):
	if body.name == "PC":
		nommable = false
#		print(body.name + "out" + name)

func swallowed():
	area.monitorable = false
	area.monitorable = false
	self.visible = false 

func spit_up():
	area.monitorable = true
	area.monitorable = true
	self.visible = true
