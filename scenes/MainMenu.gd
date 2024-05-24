extends PanelContainer

const note_png = preload("res://assets/circlehd.png")
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	$MarginContainer/HBoxContainer/VBoxContainer/VBoxContainer2/Play.grab_focus()


func _on_timer_timeout() -> void:
	var tween = create_tween()
	for _i in range(rng.randi_range(5, 10)):
		var p = Sprite2D.new()
		p.texture = note_png
		
		var scale = rng.randf_range(0.25,0.75)
		var x = rng.randi_range(500, 1280)
		p.position = Vector2(x, 900)
		p.scale = Vector2(scale, scale)
		p.z_index = 0
		p.self_modulate.a = 0.5
		p.modulate.a = 0.5
		tween.tween_property(p, "position", Vector2(x, -100), rng.randf_range(5, 10))
		tween.tween_callback(p.queue_free)
		
		add_child(p)
	tween.play()
