extends Node3D

var level_time = 0.0
@export var total_cakes = 7

func _ready():
	for nom in get_tree().get_nodes_in_group("noms"):
		if nom.name != "pig":nom.connect("body_entered", hit.bind(nom.find_child("AudioStreamPlayer3D", false)))
		pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	level_time += delta

func _on_hole_entered(body):
	body.queue_free()
	if $hole/cake:
			$hole/cake.visible = true
			$hole/cake/Area3D.set_deferred("monitorable", true)
			$hole/cake/Area3D.set_deferred("monitoring", true)
			$hole/cake/AudioStreamPlayer3D.play()


func hit(body, player):
#	print(body.name)
#	print("hit")
	player.play()
	
