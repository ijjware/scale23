extends Node3D

@onready var tree = get_tree()
@onready var rock1 = $rock1
@onready var rock2 = $rock2
@onready var rock3 = $rock3
@onready var rockmark1 = $rockmark1
@onready var rockmark2 = $rockmark2
@onready var rockmark3 = $rockmark3
var rock1true = false
var rock2true = false
var rock3true = false
var won =false

func _on_area_3d_body_entered(body):
	match(body.name):
		"rock1": 
			print("rock1")
			rock1true = true
			win()
		"rock2": 
			print("rock2")
			rock2true = true
			win()
		"rock3": 
			print("rock3")
			rock3true = true
			win()

func reset():
#	rock1.transform = rockmark1.transform
#	rock2.transform = rockmark2.transform
#	rock3.transform = rockmark3.transform
#	rock1true = false
#	rock2true = false
#	rock3true = false
	pass

func win():
	if rock1true and rock2true and rock3true:
		#spawn cake
		print("you win")
		won = true
		$scaleisland/cake.visible = true
		$scaleisland/cake/Area3D.set_deferred("monitorable", true)
		$scaleisland/cake/Area3D.set_deferred("monitoring", true)
		$scaleisland/cake/AudioStreamPlayer3D.play()
		rock1.queue_free()
		rock2.queue_free()
		rock3.queue_free()

func _on_area_3d_body_exited(body):
	match(body.name):
		"PC": if !won: reset()
		"rock1": if !won: rock1true = false
		"rock2": if !won: rock2true = false
		"rock2": if !won: rock3true = false
