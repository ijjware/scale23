extends Area3D
var can_see = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_body_entered(body):
	print(body)
	if can_see == true:
		can_see = false
		$disappear_timer.start(1)


func _on_disappear_timer_timeout():
	get_owner().visible = false
	$"../../../Cube/StaticBody3D/CollisionShape3D".disabled = true
	$reappear_timer.start(3)

func _on_reappear_timer_timeout():
	get_owner().visible = true
	$"../../../Cube/StaticBody3D/CollisionShape3D".disabled = false
	can_see = true
