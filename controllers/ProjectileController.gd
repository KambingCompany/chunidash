extends Control

class_name ProjectileController

var command_queue: Array[Command] = []
var current_time = 0

func sort_commands(a: Command, b: Command):
	return a.start_time < b.start_time

func _process(delta: float) -> void:
	_process_commands()

func _process_commands():
	var i = len(command_queue) - 1
	while true:
		if i < 0:
			break
		
		if i >= len(command_queue):
			i -= 1
			continue

		var cmd = command_queue[i]
		if cmd.start_time > current_time:
			break
		
		if not is_instance_valid(cmd.object):
			command_queue.remove_at(i)
			continue

		if not cmd.object.is_inside_tree():
			if cmd.object.is_ghost:
				$Background.add_child(cmd.object)
			else:
				$Foreground.add_child(cmd.object)
			
		var should_delete = cmd.execute(current_time)
		if should_delete:
			command_queue.remove_at(i)
			if is_instance_valid(cmd.object) and current_time > cmd.object.end_time:
				cmd.object.queue_free()
		
		# if cmd is ColorChange and cmd.end_color == Color(0, 0, 0, 1):
		# 	print(cmd.get_duration_percentage(current_time))
		# 	print(cmd.executed)
		# 	print(should_delete)
		i -= 1
