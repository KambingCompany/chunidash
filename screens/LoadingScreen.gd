extends Control

@export var song: Song
var t: Thread
var level_scene = preload("res://screens/Level.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tween = get_tree().create_tween().set_loops()
	tween.tween_property($TextureProgressBar, "radial_initial_angle", 360.0, 1.5).as_relative()
	
	t = Thread.new()
	t.start(Callable(self, "load_commands"))

func load_commands():
	return OsbConverter.new().parse_osb_to_projectiles(song.base_dir)

func _process(_delta: float) -> void:
	if t.is_alive():
		return
	
	var commands = t.wait_to_finish()
	var level: Level = level_scene.instantiate()
	level.song = song
	level.commands = commands
	Game.set_screen(level)
