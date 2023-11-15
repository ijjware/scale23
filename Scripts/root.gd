extends Node3D

@onready var player = $PC
#manages animations and interactions between objects in scene
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#handles when a player activates a spring
func _on_spring_sproing():
#	do animation
#	on animation finished:
#	TODO: modify based on current weight
	player.velocity.y = 200
	player.move_and_slide()
	pass # Replace with function body.
