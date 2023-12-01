extends Node3D

func _on_area_3d_body_entered(body):
	if body.name == "pig":
		body.home = true
		if $cake:
			$cake.visible = true
			$cake/Area3D.set_deferred("monitorable", true)
			$cake/Area3D.set_deferred("monitoring", true)
			$cake/AudioStreamPlayer3D.play()
