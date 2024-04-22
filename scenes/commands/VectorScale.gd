extends Command

class_name VectorScale

var start_x: float
var end_x: float
var start_y: float
var end_y: float

func _init(
		object: Node2D,
		start_t: int, end_t: int,
		start_x: float, end_x: float,
		start_y: float, end_y: float
	):
	super(object, start_t, end_t)
	self.start_x = start_x
	self.end_x = end_x
	self.start_y = start_y
	self.end_y = end_y

func execute(time: int):
	var percentage = get_duration_percentage(time)
	var current_x = start_x + percentage * (end_x - start_x)
	var current_y = start_y + percentage * (end_y - start_y)
	object.scale = Vector2(current_x, current_y)
