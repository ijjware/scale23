extends Camera3D

@onready var marker = $"../CharacterBody3D/followDAD/Marker3D"
@onready var follow = $"../CharacterBody3D/followDAD"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
#		self.transform = marker.global_transform
		self.transform = self.transform.interpolate_with(marker.global_transform, 0.07)
		look_at(follow.global_position)
