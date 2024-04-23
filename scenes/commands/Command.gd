extends RefCounted

class_name Command

var object: Projectile
var start_time: int
var end_time: int
var executed: bool = false
var duration: int = 0:
	get:
		return end_time - start_time

func _init(object: Projectile, start_t: int, end_t: int):
	self.object = object
	start_time = start_t
	end_time = end_t

func execute(time: int):
	assert(false, "This is meant to be overriden")

func get_duration_percentage(time: int):
	if time > end_time or start_time == end_time:
		return 1
	return float(time - start_time) / float(duration)
