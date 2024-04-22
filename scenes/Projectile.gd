extends Sprite2D

class_name Projectile

var commands
var is_ghost: bool
var start_position: Vector2
var start_time: int

#func _init(commands: Array[Command], start_position: Vector2, is_ghost: bool):
	#self.commands = commands
	#self.start_position = start_position
	#self.is_ghost = is_ghost
	#self.start_time = commands[0].start_time

func _ready() -> void:
	self.position = start_position
	if is_ghost:
		return

	# TODO: Optimize this
	print(texture)
	for collider in create_colliders(texture):
		add_child(collider)

func execute_commands(t: int):
	var i = 0
	if len(commands) == 0:
		queue_free()
		return

	while true:
		if i >= len(commands):
			break
		
		var cmd = commands[i]
		if cmd.start_time > t:
			break

		if t > cmd.end_time:
			commands.remove_at(i)
			continue
		
		cmd.execute(t)
		i += 1

static func create_colliders(texture: Texture):
	var colliders: Array[CollisionPolygon2D] = []
	var bitmap = BitMap.new()
	bitmap.create_from_image_alpha(texture.get_image())

	var polygons = bitmap.opaque_to_polygons(Rect2(Vector2(0, 0), bitmap.get_size()))

	for polygon in polygons:
		var collider = CollisionPolygon2D.new()
		collider.polygon = polygon
		colliders.append(collider)
	return colliders

