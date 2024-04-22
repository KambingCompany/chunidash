extends RefCounted

class_name OsbConverter

var cache: Dictionary = {}
const projectile_scene = preload("res://scenes/Projectile.tscn")

func create_projectile(commands: Array[Command], start_position: Vector2, is_ghost: bool, texture: Texture):
	var p = projectile_scene.instantiate()
	p.commands = commands
	p.start_position = start_position
	p.is_ghost = is_ghost
	p.start_time = commands[0].start_time
	p.texture = texture
	for command in commands:
		command.object = p
	return p


func parse_osb_to_projectiles(base_dir: String):
	var songdir = "res://assets/songs/" + base_dir + "/"
	var sprites = OsbParser.parse(songdir + "projectiles.osb")
	
	var projectiles: Array[Projectile] = []
	for sprite in sprites:
		var path = songdir + sprite.filepath
		if not cache.has(path):
			cache[path] = load(path)
		
		var commands: Array[Command] = []
		for cmd in sprite.commands:
			var command: Command
			match cmd.type:
				OsbParser.CommandType.Move:
					if len(cmd.params) == 2:
						cmd.params.append(cmd.params[0])
						cmd.params.append(cmd.params[1])
					
					command = Move.new(null, cmd.startTime, cmd.endTime, int(cmd.params[0]), int(cmd.params[2]), int(cmd.params[1]), int(cmd.params[3]))
				OsbParser.CommandType.Scale:
					if len(cmd.params) == 1:
						cmd.params.append(cmd.params[0])
					
					command = Scale.new(null, cmd.startTime, cmd.endTime, float(cmd.params[0]), float(cmd.params[1]))
				OsbParser.CommandType.Vector:
					if len(cmd.params) == 2:
						cmd.params.append(cmd.params[0])
						cmd.params.append(cmd.params[1])
						
					command = VectorScale.new(null, cmd.startTime, cmd.endTime, float(cmd.params[0]), float(cmd.params[2]), float(cmd.params[1]), float(cmd.params[3]))
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
			
			if command == null:
				continue
			commands.append(command)
		
		if len(commands) == 0:
			continue

		var p = create_projectile(
			commands,
			Vector2(sprite.x, sprite.y),
			sprite.layer == OsbParser.Layer.Background,
			cache[path]
		)
		projectiles.append(p)
	return projectiles
