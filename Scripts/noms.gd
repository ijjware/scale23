extends Node

signal nom(node)
var nommable = false
@onready var area = $Area3D

func _ready():
	area.connect("body_exited", _on_area_3d_body_exited)
	area.connect("body_entered", _on_area_3d_body_entered)

func _process(delta):
	if Input.is_action_just_pressed("eat") and nommable:
#		$PanelS.visible = false
		#catch signal at scene root
		emit_signal("nom", self)

func _on_area_3d_body_entered(body):
	if body.name == "PC":
		nommable = true
#		$PanelS.visible = true
		print (body.name + "in" + name)
		pass # Replace with function body.

func _on_area_3d_body_exited(body):
	#hide context button
	if body.name == "PC":
		nommable = false
		print(body.name + "out" + name)
#		$PanelS.visible = false

func swallowed():
	area.monitorable = false
	area.monitorable = false

func spit_up():
	area.monitorable = true
	area.monitorable = true
