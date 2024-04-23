extends Node2D
class_name RhythmBar

signal note_judged(judgement: Judgement)

enum Judgement {
	PERFECT,
	GREAT,
	GOOD,
	MISS
}

const note = preload("res://scenes/Note.tscn")

@export var current_time: int = 0

var queue: Array[Note]

const PERFECT_WINDOW = 33.33
const GREAT_WINDOW = 50.0
const GOOD_WINDOW = 66.67
const MISS_WINDOW = 100.0
const MS_WINDOW = 1000.0

# Called when the node enters the scene tree for the first time.
func load(rhythm: Array[int]) -> void:
	for t in rhythm:
		var n = note.instantiate()
		n.time = t
		queue.append(n)

func handle_input():
	var first = queue.front()
	if not first:
		return
	var delta = abs(current_time - first.time)
	
	if delta > MISS_WINDOW + 33: # + 1 frame
		return false
	
	if delta > MISS_WINDOW:
		emit_signal("note_judged", Judgement.MISS)
		return
	
	if delta > GOOD_WINDOW:
		emit_signal("note_judged", Judgement.GOOD)
	elif delta > GREAT_WINDOW:
		emit_signal("note_judged", Judgement.GREAT)
	else:
		emit_signal("note_judged", Judgement.PERFECT)
	first.queue_free()

func _unhandled_key_input(event: InputEvent):
	if event is InputEventKey and event.pressed:
		var key_event: InputEventKey = event
		if key_event.keycode & KEY_CODE_MASK:
			handle_input()

func _ready() -> void:
	note_judged.connect(GameState.process_judgement)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move_notes()

func move_notes():
	var i = 0
	while true:
		if i >= len(queue):
			break
		
		var note = queue[i]
		if not is_instance_valid(note):
			queue.remove_at(i)
			continue
		
		if note.time > current_time + MS_WINDOW + 2000:
			break
		
		if not note.is_inside_tree():
			add_child(note)
		
		if current_time - note.time > MISS_WINDOW:
			note.queue_free()
			queue.remove_at(i)
			emit_signal("note_judged", Judgement.MISS)
			continue

		if not note.visible and note.time - current_time < (MS_WINDOW + 2000):
			note.visible = true

		var orig: Vector2 = note.position
		note.position = Vector2(orig.x, 600 * (1.0 - (note.time - current_time) / MS_WINDOW))
		i += 1

func flash_color(color: Color):
	var tween = create_tween()
	tween.tween_property($Line2D, "modulate", color, 0.05)
	tween.tween_property($Line2D, "modulate", Color.WHITE, 0.1)
	tween.play()
