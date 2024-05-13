extends Node

@export var audio: AudioStream
@export var current_time: int

signal song_end
const hit_hs = preload("res://assets/hit.ogg")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AudioStreamPlayer.stream = audio
	$AudioStreamPlayer.finished.connect(_on_finish)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var time = $AudioStreamPlayer.get_playback_position() + AudioServer.get_time_since_last_mix()
	time -= AudioServer.get_output_latency()
	time *= 1000 # Convert to ms
	time += UserSettings.offset

	current_time = int(time)

func start():
	$AudioStreamPlayer.play()

func restart():
	$AudioStreamPlayer.seek(0)

func toggle_pause():
	$AudioStreamPlayer.stream_paused = not $AudioStreamPlayer.stream_paused

func set_audio(new_audio: AudioStream):
	audio = new_audio
	_ready()

func _on_finish():
	song_end.emit()

func play_sfx():
	var sfx_player = AudioStreamPlayer.new()
	sfx_player.stream = hit_hs
	sfx_player.bus = "SFX"
	
	add_child(sfx_player)
	sfx_player.play()
	await sfx_player.finished
	sfx_player.queue_free()
