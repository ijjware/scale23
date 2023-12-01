extends Node3D

func _process(delta):
	pass
	
	
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("rotate")

func _on_area_3d_body_entered(body):
	if body.name == "PC":
		#body.call("add_stomach")
		body.call("eat_cake")
		queue_free()
