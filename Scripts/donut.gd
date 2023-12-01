extends Node3D

func _ready():
	$AnimationPlayer.play("rotate")

func _on_area_3d_body_entered(body):
	if body.name == "PC":
		body.victory()
		body.off = true
		$"../UI/PanelContainer".visible = false
		var cakes = body.stomachSize - 1
		var total_cakes = $"..".total_cakes
		#var total = $"..".level_time
		var total = floor($"..".level_time)
		var min = floor(total / 60)
		var sec = total - (min * 60)
		if sec < 10:
			sec = "0" + str(sec)
		$"../EndUI/Control/CenterContainer/Panel/Time".text = "[center]%s : %s[/center]" % [str(min), str(sec)]
		$"../EndUI/Control/CenterContainer/Panel/Cake".text = "[center]%s / %s[/center]" % [str(cakes), str(total_cakes)]
		$"../EndUI/Control".visible = true
		pass
