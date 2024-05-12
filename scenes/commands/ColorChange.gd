extends Command

class_name ColorChange

var start_color: Color
var end_color: Color

func _init(object: Node2D, start_t: int, end_t: int, start_color: Color, end_color: Color):
	super(object, start_t, end_t)
	self.start_color = start_color
	self.end_color = end_color
	
func effect(time: int):
	var percentage = get_duration_percentage(time)
	var value = start_color + percentage * (end_color - start_color)
	var original_alpha = object.self_modulate.a
	object.self_modulate = value
	object.self_modulate.a = original_alpha
