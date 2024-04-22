extends Command

class_name Scale

var start_scale: float
var end_scale: float

func _init(object: Node2D, start_t: int, end_t: int, start_s: float, end_s: float):
	super(object, start_t, end_t)
	start_scale = start_s
	end_scale = end_s

func execute(time: int):
	var percentage = get_duration_percentage(time)
	var value = start_scale + percentage * (end_scale - start_scale)
	object.scale = Vector2(value, value)
