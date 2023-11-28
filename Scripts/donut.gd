extends Node3D

func _ready():
	$AnimationPlayer.play("rotate")

func _on_area_3d_body_entered(body):
	if body.name == "PC":
#		end game
		pass
