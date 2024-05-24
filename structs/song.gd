extends Resource
class_name Song

@export var artist: String
@export var title: String
@export var rhythm: PackedInt32Array
@export var audio: AudioStream
@export var base_dir: String
@export var move_toggles: PackedInt32Array
@export var boss_name: String
@export var dialogue: String
@export var level_image: Texture2D
@export var song_index: int

func _init(artist = "", title = "", rhythm = [], audio = null, base_dir = "", move_toggles = [], boss_name = "", dialogue = "", level_image = null, song_index = null) -> void:
	self.artist = artist
	self.title = title
	self.rhythm = rhythm
	self.audio = audio
	self.base_dir = base_dir
	self.move_toggles = move_toggles
	self.boss_name = boss_name
	self.dialogue = dialogue
	self.level_image = level_image
	self.song_index = song_index
