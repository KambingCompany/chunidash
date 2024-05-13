extends Node

signal offset_change(value: int)
signal master_volume_change(value: int)
signal song_volume_change(value: int)
signal sfx_volume_change(value: int)

const CONFIG_PATH = "user://config.ini"

@onready var master_bus_idx = AudioServer.get_bus_index("Master")
@onready var sfx_bus_idx = AudioServer.get_bus_index("SFX")
@onready var song_bus_idx = AudioServer.get_bus_index("Song")

@export var master_volume: int = 50:
	set(value):
		master_volume_change.emit(value)
		AudioServer.set_bus_volume_db(master_bus_idx, linear_to_db(value / 100.0))
		master_volume = value
		config.set_value("settings", "master_volume", value)
		config.save(CONFIG_PATH)

@export var song_volume: int = 50:
	set(value):
		song_volume_change.emit(value)
		AudioServer.set_bus_volume_db(song_bus_idx, linear_to_db(value / 100.0))		
		song_volume = value
		config.set_value("settings", "song_volume", value)
		config.save(CONFIG_PATH)

@export var sfx_volume: int = 50:
	set(value):
		sfx_volume_change.emit(value)
		AudioServer.set_bus_volume_db(sfx_bus_idx, -6 + linear_to_db(value / 100.0))		
		sfx_volume = value
		config.set_value("settings", "sfx_volume", value)
		config.save(CONFIG_PATH)

@export var offset: int = 0:
	set(value):
		offset_change.emit(value)
		offset = value
		config.set_value("settings", "offset", value)
		config.save(CONFIG_PATH)

var config: ConfigFile
func _ready() -> void:
	config = ConfigFile.new()
	var err = config.load(CONFIG_PATH)
	if err == OK:
		master_volume = config.get_value("settings", "master_volume", 50)
		song_volume = config.get_value("settings", "song_volume", 50)
		sfx_volume = config.get_value("settings", "sfx_volume", 50)
		offset = config.get_value("settings", "offset", 0)
	else:
		master_volume = 50
		song_volume = 50
		sfx_volume = 50
		offset = 0
