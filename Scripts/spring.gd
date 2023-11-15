extends Node3D

var springable = false
signal sproing
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("context button S") and springable:
		$PanelS.visible = false
		springable = false
		#catch signal at scene root
		emit_signal("sproing")

#player stands in trigger zone
func _on_trigger_zone_body_entered(body):
	#display context button
	if body.name == "PC":
		$PanelS.visible = true
#		print (body.name + "in")
		springable = true

func _on_trigger_zone_body_exited(body):
	#hide context button
	if body.name == "PC":
		$PanelS.visible = false
		springable = false
#		print (body.name + "out")
