extends Node

signal on_death

const BASE_HEALTH: float = 100.0
const IFRAME_DURATION = 100.0

enum Difficulty {
	EASY,
	MEDIUM,
	HARD
}

# Set this before each level start based on player's diff choice
var difficulty = Difficulty.EASY

var health: float = BASE_HEALTH
var score = 0
var accuracy = 1.0
var alive = true

var iframe = 0

var colliding: bool

var hit_count = 0
# Judgements
# TODO: Refactor (should this be separate variables or a dictionary?)
var perfect = 0
var great = 0
var good = 0
var miss = 0

func reset_game_state():
	health = BASE_HEALTH
	score = 0
	alive = true
	
func process_judgement(judgement: RhythmBar.Judgement):
	match judgement:
		RhythmBar.Judgement.PERFECT:
			health = clamp(health + 1.0, 0, BASE_HEALTH)
			perfect += 1
		RhythmBar.Judgement.GREAT:
			health = clamp(health + 0.5, 0, BASE_HEALTH)
			great += 1
		RhythmBar.Judgement.GOOD:
			health = clamp(health + 0.2, 0, BASE_HEALTH)
			good += 1
		RhythmBar.Judgement.MISS:
			health = clamp(health - 0.1, 0, BASE_HEALTH)
			miss += 1

	hit_count += 1
	accuracy = (perfect + great * 0.75 + good * 0.5) / hit_count
	
func _process(delta):
	if alive and health <= 0:
		on_death.emit()
		alive = false
	
	if iframe <= 0 and colliding:
		iframe = IFRAME_DURATION
		match difficulty:
			Difficulty.EASY:
				health -= 5
			Difficulty.MEDIUM:
				health -= 10
			Difficulty.HARD:
				health -= 15
		
	if iframe > 0:
		iframe -= delta * 1000
