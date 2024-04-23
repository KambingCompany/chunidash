extends Command

class_name MoveY

var start: float
var end: float

func _init(
		object: Node2D,
		start_t: int, end_t: int,
		start: float, end: float
	):
	super(object, start_t, end_t)
	self.start = start
	self.end = end

func execute(time: int):
	var percentage = get_duration_percentage(time)
	var current = start + percentage * (end - start)
	object.position = Vector2(object.position.x, current)
