extends Command

class_name Rotate

var start_rotation: float
var end_rotation: float

func _init(object: Node2D, start_t: int, end_t: int, start_rotation: float, end_rotation: float):
	super(object, start_t, end_t)
	self.start_rotation = start_rotation
	self.end_rotation = end_rotation

func effect(time: int):
	var percentage = get_duration_percentage(time)
	var value = start_rotation + percentage * (end_rotation - start_rotation)
	object.rotation = value
