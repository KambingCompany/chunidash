extends RefCounted

class_name Command

var object: Node2D
var start_time: int
var end_time: int
var duration: int = 0:
	get:
		return end_time - start_time

func _init(object: Node2D, start_t: int, end_t: int):
	self.object = object
	start_time = start_t
	end_time = end_t

func execute(time: int):
	assert(false, "This is meant to be overriden")

func get_duration_percentage(time: int):
	return float(time - start_time) / float(duration)
