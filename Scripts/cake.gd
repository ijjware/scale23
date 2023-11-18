extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("rotate")

func _on_area_3d_body_entered(body):
	if body.name == "PC":
		body.call("add_stomach")
		queue_free()

#make noise, sparkle and shine, skinner's box stuff
