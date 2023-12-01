extends Node3D

var level_time = 0.0
@export var total_cakes = 8

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	level_time += delta

func _on_hole_entered(body):
	body.queue_free()
	if $hole/cake:
			$hole/cake.visible = true
			$hole/cake/Area3D.set_deferred("monitorable", true)
			$hole/cake/Area3D.set_deferred("monitoring", true)
