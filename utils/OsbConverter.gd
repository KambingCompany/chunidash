extends RefCounted

class_name OsbConverter

var texture_cache: Dictionary = {}
var collider_cache: Dictionary = {}
const projectile_scene = preload("res://scenes/Projectile.tscn")

func create_projectile(commands: Array[Command], start_position: Vector2, is_ghost: bool, texture: Texture):
	var p = projectile_scene.instantiate()
	p.start_position = start_position
	p.is_ghost = is_ghost
	p.start_time = commands[0].start_time
	p.texture = texture
	p.end_time = 0
	
	for command in commands:
		command.object = p

	for cmd in commands:
		p.end_time = max(cmd.end_time, p.end_time)
	return p


func parse_osb_to_projectiles(base_dir: String):
	var songdir = "res://assets/songs/" + base_dir + "/"
	var sprites = OsbParser.parse(songdir + "projectiles.osb")

	var commands_queue: Array[Command]
	for sprite in sprites:
		var path = songdir + sprite.filepath
		if not texture_cache.has(path):
			texture_cache[path] = load(path)
			collider_cache[path] = Projectile.create_colliders(texture_cache[path])
		
		var commands: Array[Command] = []
		for cmd in sprite.commands:
			var command: Command
			match cmd.type:
				OsbParser.CommandType.Move:
					if len(cmd.params) == 2:
						cmd.params.append(cmd.params[0])
						cmd.params.append(cmd.params[1])
					
					command = Move.new(
						null, cmd.startTime, cmd.endTime,
						VectorHelper.OsuVector(int(cmd.params[0]), int(cmd.params[1])),
						VectorHelper.OsuVector(int(cmd.params[2]), int(cmd.params[3]))
					)
				OsbParser.CommandType.Scale:
					if len(cmd.params) == 1:
						cmd.params.append(cmd.params[0])
					
					command = Scale.new(
						null, cmd.startTime, cmd.endTime,
						VectorHelper.rescale_y(float(cmd.params[0])),
						VectorHelper.rescale_y(float(cmd.params[1]))
					)
				OsbParser.CommandType.Vector:
					if len(cmd.params) == 2:
						cmd.params.append(cmd.params[0])
						cmd.params.append(cmd.params[1])
						
					command = VectorScale.new(
						null, cmd.startTime, cmd.endTime,
						VectorHelper.OsuVector(int(cmd.params[0]), int(cmd.params[1])),
						VectorHelper.OsuVector(int(cmd.params[2]), int(cmd.params[3]))
					)
				OsbParser.CommandType.Color:
					if len(cmd.params) == 3:
						cmd.params.append(cmd.params[0])
						cmd.params.append(cmd.params[1])
						cmd.params.append(cmd.params[2])

					command = ColorChange.new(null, cmd.startTime, cmd.endTime, Color(int(cmd.params[0]), int(cmd.params[1]), int(cmd.params[2])), Color(int(cmd.params[3]), int(cmd.params[4]), int(cmd.params[5])))
				OsbParser.CommandType.Rotate:
					if len(cmd.params) == 1:
						cmd.params.append(cmd.params[0])
					command = Rotate.new(null, cmd.startTime, cmd.endTime, float(cmd.params[0]), float(cmd.params[1]))
				OsbParser.CommandType.MoveX:
					if len(cmd.params) == 1:
						cmd.params.append(cmd.params[0])
					command = MoveX.new(
						null, cmd.startTime, cmd.endTime,
						VectorHelper.rescale_x(float(cmd.params[0])),
						VectorHelper.rescale_x(float(cmd.params[1]))
					)
				OsbParser.CommandType.MoveY:
					if len(cmd.params) == 1:
						cmd.params.append(cmd.params[0])
					command = MoveY.new(
						null, cmd.startTime, cmd.endTime,
						VectorHelper.rescale_y(float(cmd.params[0])),
						VectorHelper.rescale_y(float(cmd.params[1]))
					)
				OsbParser.CommandType.Fade:
					if len(cmd.params) == 1:
						cmd.params.append(cmd.params[0])

					command = Fade.new(
						null, cmd.startTime, cmd.endTime,
						float(cmd.params[0]),
						float(cmd.params[1])
					)

			if command == null:
				continue
			commands.append(command)
		
		if len(commands) == 0:
			continue

		var is_ghost = sprite.layer == OsbParser.Layer.Background
		var p = create_projectile(
			commands,
			VectorHelper.OsuVector(sprite.x, sprite.y),
			is_ghost,
			texture_cache[path]
		)
		if not is_ghost:
			for collider in collider_cache[path]:
				p.get_node("Area2D").add_child(collider.duplicate())

		commands_queue.append_array(commands)
	
	commands_queue.sort_custom(compare_command)
	return commands_queue

func compare_command(a: Command, b: Command):
	return a.start_time > b.start_time
