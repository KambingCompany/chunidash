extends RefCounted

class_name VectorHelper

const vector_ratio = Vector2(1280, 720) / Vector2(854, 480)
const x_ratio = 1280.0 / 854.0
const y_ratio = 720.0 / 480.0

static func OsuVector(x: float, y: float):
	return (Vector2(x, y) + Vector2(107, 0)) * vector_ratio

static func rescale_x(x: float):
	return (x + 107.0) * x_ratio

static func rescale_y(y: float):
	return y * y_ratio
