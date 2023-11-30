extends Node3D

#manages animations and interactions between objects in scene
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_hole_entered(body):
	body.queue_free()
	if $hole/cake:
			$hole/cake.visible = true
			$hole/cake/Area3D.set_deferred("monitorable", true)
			$hole/cake/Area3D.set_deferred("monitoring", true)
