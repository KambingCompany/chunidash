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
		
		var cmd = command_queue[i]
		if cmd.start_time > current_time:
			break
		
		if current_time >= cmd.end_time and cmd.executed:
			command_queue.remove_at(i)
			if is_instance_valid(cmd.object) and current_time > cmd.object.end_time:
				cmd.object.queue_free()
			i -= 1
			continue
		
		if not is_instance_valid(cmd.object):
			command_queue.remove_at(i)
			continue

		if not cmd.object.is_inside_tree():
			add_child(cmd.object)
			
		cmd.execute(current_time)
		if current_time > cmd.end_time:
			cmd.executed = true
		i -= 1
