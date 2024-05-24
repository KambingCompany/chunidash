extends PanelContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if (event is InputEventKey and event.pressed) or (event is InputEventMouseButton and event.is_pressed()):
		Game.set_screen(load("res://scenes/MainMenu.tscn").instantiate())

func _on_video_stream_player_finished():
	Game.set_screen(load("res://scenes/MainMenu.tscn").instantiate())
