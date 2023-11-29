extends Node3D

var springable = false
var current_body = null
@export var weight_multiplier = 75
@export var spring_amount = 200
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("interact") and current_body != null:
		$PanelS.visible = false
		var weight = 1
		if current_body.get('stomachs') != null:
			# I add by one so that I don't run into 0s
			weight = current_body.get('stomachs').size() + 1
		var weight_factor = weight * weight_multiplier
		current_body.velocity.y = spring_amount - weight_factor
		current_body.move_and_slide()
		current_body = null
#player stands in trigger zone
func _on_trigger_zone_body_entered(body):
	#display context button
	if body.name == "PC":
		$PanelS.visible = true
		current_body = body
#		print (body.name + "in" +name)

func _on_trigger_zone_body_exited(body):
	#hide context button
	if body.name == "PC":
		$PanelS.visible = false
		current_body = null
#		print (body.name + "out" +name)
