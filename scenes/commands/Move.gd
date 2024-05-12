extends Command

class_name Move

var start: Vector2
var end: Vector2

func _init(
		object: Node2D,
		start_t: int, end_t: int,
		start: Vector2, end: Vector2
	):
	super(object, start_t, end_t)
	self.start = start
	self.end = end

func effect(time: int):
	var percentage = get_duration_percentage(time)
	var current = start + percentage * (end - start)
	object.position = current
