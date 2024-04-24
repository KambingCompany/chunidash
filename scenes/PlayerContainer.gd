extends Panel


# Called when the node enters the scene tree for the first time.
func _ready():
	find_child("CharacterController").bounds = $Container.get_size()
