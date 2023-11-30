extends Node3D
var can_see = true
@export var disappear_time = 1.0
@export var reappear_time = 2.0
@export var weight_factor = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_disappear_timer_timeout():
	self.visible = false
	$scalecrack/Cube/StaticBody3D/CollisionShape3D.disabled = true
	$scalecrack/Cube/StaticBody3D/Area3D/reappear_timer.start(reappear_time)

func _on_reappear_timer_timeout():
	self.visible = true
	$scalecrack/Cube/StaticBody3D/CollisionShape3D.disabled = false
	can_see = true


func _on_area_3d_body_entered(body):
	var weight = 1
	if body.get('stomachs') != null:
		# I add by one so that I don't run into 0s
		weight = body.get('stomachs').size() + 1
	var weight_divider = weight / weight_factor
	if can_see == true:
			can_see = false
			$scalecrack/Cube/StaticBody3D/Area3D/disappear_timer.start(disappear_time / weight_divider)
			print($scalecrack/Cube/StaticBody3D/Area3D/disappear_timer)
