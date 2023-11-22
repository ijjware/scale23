extends Node3D

@onready var tree = get_tree()
@onready var player = $PC
var noms = Array() 
#manages animations and interactions between objects in scene
# Called when the node enters the scene tree for the first time.
func _ready():
	noms = tree.get_nodes_in_group("noms")
	for nom in noms:
		nom.connect("nom", _on_nom)
	noms.clear()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for object in player.stomachs:
		object.global_position = player.hideout.global_position
		object.linear_velocity.y = 0

#handles when a player activates a spring
func _on_spring_sproing():
#	do animation
#	on animation finished:
#	TODO: modify based on current weight
	player.velocity.y = 150
	player.move_and_slide()

func _on_nom(nommed):
	noms.push_front(nommed)
#	print("nom"+nommed.name)
	await tree.create_timer(0.1).timeout
	if noms.size() > 1: 
		noms.pop_back()
		return
	var nom = noms.pop_front()
	swallow(nom)

func swallow(nom):
	if player.stomachSize > player.stomachs.size() :
		player.stomachs.push_front(nom)
		nom.swallowed()
		noms.clear()
