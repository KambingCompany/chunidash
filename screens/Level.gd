extends Control

class_name Level

var song: Song
var commands: Array[Command]
@onready var projectile_controller: ProjectileController = $ProjectileController
@onready var rhythm_bar: RhythmBar = $PlayerContainer/Container/CharacterController/RhythmBar
@onready var character_controller: CharacterController = $PlayerContainer/Container/CharacterController
@onready var boss_container = $HUDContainer/MarginContainer/VBoxContainer/MarginContainer3/BossContainer
@onready var random = RandomNumberGenerator.new()
var orig_position

var projectile = preload ("res://scenes/Projectile.tscn")
var converter = OsbConverter.new()
var started = false

func create_projectile(commands: Array[Command], start_position: Vector2, is_ghost: bool, texture: Texture):
	var p = projectile.instantiate()
	p.commands = commands
	p.start_position = start_position
	p.is_ghost = is_ghost
	p.start_time = commands[0].start_time
	p.texture = texture
	for command in commands:
		command.object = p
	return p

func _ready() -> void:
	if song.dialogue:
		DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
		$Dialogue.start_dialogue(song.dialogue)
	else:
		$Dialogue.queue_free()
		_start()

func _start() -> void:
	orig_position = boss_container.position
	character_controller.load_can_move_toggle_rhythm(song.move_toggles)
	rhythm_bar.note_judged.connect(_on_rhythm_bar_note_judged)

	character_controller.can_move = true
	projectile_controller.command_queue = commands
	$AudioController.set_audio(song.audio)
	$AudioController.start()
	$AudioController.song_end.connect(_on_finish)
	$HUDContainer/MarginContainer/VBoxContainer/MarginContainer3/BossContainer/BossLabel.text = song.boss_name
	
	rhythm_bar.load(song.rhythm)
	# Reset game state on start
	GameState.start_new_game(GameState.Difficulty.EASY)
	GameState.current_song = song
	GameState.on_death.connect(on_player_death)
	GameState.all_notes = len(song.rhythm)
	started = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if started:
		rhythm_bar.current_time = $AudioController.current_time
		projectile_controller.current_time = $AudioController.current_time
		character_controller.current_time = $AudioController.current_time

func _on_rhythm_bar_note_judged(judgement: int) -> void:
	if judgement == RhythmBar.Judgement.GREAT:
		rhythm_bar.flash_color(Color.SKY_BLUE)
	elif judgement == RhythmBar.Judgement.GOOD:
		rhythm_bar.flash_color(Color.GREEN)
	elif judgement == RhythmBar.Judgement.MISS:
		rhythm_bar.flash_color(Color.RED)

	if judgement != RhythmBar.Judgement.MISS:
		$AudioController.play_sfx()
		
		var tween = create_tween()
		var c = random.randi_range(2, 5)
		tween.tween_property(boss_container, "position:x", c, 0.025).as_relative()
		tween.tween_property(boss_container, "position:x", c * -1.1, 0.025).as_relative()
		tween.tween_property(boss_container, "position", orig_position, 0.25)

func _on_finish():
	if GameState.boss_health <= 0 and GameState.health > 0:
		SaveManager.increment_progress(song)
	Game.change_scene_to_packed(preload("res://scenes/ResultScreen.tscn"))

func on_player_death() -> void:
	pass

func _on_dialogue_ended(_resource: DialogueResource) -> void:
	_start()
