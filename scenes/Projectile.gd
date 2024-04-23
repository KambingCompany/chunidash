extends Sprite2D

class_name Projectile

var is_ghost: bool
var start_position: Vector2
var start_time: int
var end_time: int

func _ready() -> void:
	self.position = start_position
	if is_ghost:
		return


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

