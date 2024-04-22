extends Command

class_name Move

var start_x: int
var end_x: int
var start_y: int
var end_y: int

func _init(
		object: Node2D,
		start_t: int, end_t: int,
		start_x: int, end_x: int,
		start_y: int, end_y: int
	):
	super(object, start_t, end_t)
	self.start_x = start_x
	self.end_x = end_x
	self.start_y = start_y
	self.end_y = end_y

func execute(time: int):
	var percentage = get_duration_percentage(time)
	var current_x = float(start_x) + percentage * float(end_x - start_x)
	var current_y = float(start_y) + percentage * float(end_y - start_y)
	object.position = Vector2(current_x, current_y)
