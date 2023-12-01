extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var cakes = $"../PC".stomachSize - 1
	$PanelContainer/CenterContainer/Cake.text = "[center]Cakes : " + str(cakes) + "[/center]"
	pass
