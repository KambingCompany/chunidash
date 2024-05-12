extends Command

class_name Fade

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

func effect(time: int):
	var percentage = get_duration_percentage(time)
	var current = start + percentage * (end - start)
	object.self_modulate.a = current
