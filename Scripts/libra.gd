extends Node3D

@onready var tree = get_tree()
@onready var rock1 = $rock1
@onready var rock2 = $rock2
@onready var rock3 = $rock3
@onready var rockmark1 = $rockmark1
@onready var rockmark2 = $rockmark2
@onready var rockmark3 = $rockmark3
var numrocks = 0

func _on_area_3d_body_entered(body):
	match(body.name):
		"rock1": if numrocks <3: numrocks+=1; win()
		"rock2": if numrocks <3: numrocks+=1; win()
		"rock2": 
			if numrocks <3: 
				numrocks+=1
				win()

func reset():
	rock1.transform = rockmark1.transform
	rock2.transform = rockmark2.transform
	rock3.transform = rockmark3.transform
	numrocks = 0

func win():
	if numrocks == 3:
		#spawn cake
		$scaleisland/cake.visible = true
		$scaleisland/cake/Area3D.monitorable = true
		$scaleisland/cake/Area3D.monitoring = true
		rock1.queue_free()
		rock2.queue_free()
		rock3.queue_free()

func _on_area_3d_body_exited(body):
	match(body.name):
		"PC": if numrocks < 3: reset()
		"rock1": if numrocks >0: numrocks-=1
		"rock2": if numrocks >0: numrocks-=1
		"rock2": if numrocks >0: numrocks-=1
