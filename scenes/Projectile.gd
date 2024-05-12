extends Sprite2D

class_name Projectile

var is_ghost: bool
var start_position: Vector2
var start_time: int
var end_time: int

func _ready() -> void:
	self_modulate = Color(1, 1, 1, 1)
	self.position = start_position
	if is_ghost:
		return
	
static func create_colliders(texture: Texture):
	var colliders: Array[CollisionPolygon2D] = []
	var bitmap = BitMap.new()
	bitmap.create_from_image_alpha(texture.get_image())

	var polygons = bitmap.opaque_to_polygons(Rect2(Vector2(0, 0), bitmap.get_size()))
	var dimension = bitmap.get_size()

	for polygon in polygons:
		# Recenter the polygons, current is offsetted
		var new_polygons: PackedVector2Array = []
		for dot in polygon:
			new_polygons.append(
				Vector2(
					float(dot.x) - (float(dimension.x) / 2.0),
					float(dot.y) - (float(dimension.y) / 2.0))
			)

		var collider = CollisionPolygon2D.new()
		collider.polygon = new_polygons
		colliders.append(collider)

	return colliders

func _on_area_2d_body_entered(body):
	GameState.colliding = true

func _on_area_2d_body_exited(body):
	GameState.colliding = false
