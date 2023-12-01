extends Node3D

@export var triggerWeight = 3

func _on_animation_player_animation_started(anim_name):
	if anim_name == "CubeAction" :
		$StaticBody3D/door.queue_free()
		$zone.queue_free()

func _on_zone_body_entered(body):
	if body.name == "PC":
		if body.stomachs.size() >= triggerWeight:
			$Gate/AnimationPlayer.play("CubeAction")
