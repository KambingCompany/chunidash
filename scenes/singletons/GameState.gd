extends Node

signal on_death

const BASE_HEALTH: float = 100.0
const IFRAME_DURATION = 100.0

enum Difficulty {
	EASY,
	MEDIUM,
	HARD
}

const DIFFICULTY_MULTIPLIERS = {
	Difficulty.EASY: 0.75,
	Difficulty.MEDIUM: 1.00,
	Difficulty.HARD: 1.25,
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
var all_notes = 0
var combo = 0

# Judgements
# TODO: Refactor (should this be separate variables or a dictionary?)
var perfect = 0
var great = 0
var good = 0
var miss = 0

# Boss Health
var initial_boss_health = 5000
var boss_health = 5000

func start_new_game(difficulty: Difficulty):
	health = 50
	score = 0
	combo = 0
	hit_count = 0
	alive = true
	
	# Boss Health
	boss_health = 5000
	initial_boss_health = 5000
	
	# I-Frame reset
	iframe = 0
	difficulty = difficulty
	
	# Judgement Reset
	perfect = 0
	great = 0
	good = 0
	miss = 0

func _calculate_score(hit_value: int, combo: int, difficulty: Difficulty):
	return hit_value * (1 + (clamp(combo - 1, 0, INF) * DIFFICULTY_MULTIPLIERS[difficulty]) / 25)

func _calculate_damage(judgement: RhythmBar.Judgement):
	var accuracy_value = 0
	match judgement:
		RhythmBar.Judgement.PERFECT:
			accuracy_value = 1
		RhythmBar.Judgement.GREAT:
			accuracy_value = 0.75
		RhythmBar.Judgement.GOOD:
			accuracy_value = 0.5
	
	return (initial_boss_health / (0.9 * all_notes)) * accuracy_value

func process_judgement(judgement: RhythmBar.Judgement):
	match judgement:
		RhythmBar.Judgement.PERFECT:
			health = clamp(health + 1.0, 0, BASE_HEALTH)
			score += _calculate_score(300, combo, difficulty)
			perfect += 1
			combo += 1
		RhythmBar.Judgement.GREAT:
			health = clamp(health + 0.5, 0, BASE_HEALTH)
			score += _calculate_score(100, combo, difficulty)
			great += 1
			combo += 1
		RhythmBar.Judgement.GOOD:
			health = clamp(health + 0.2, 0, BASE_HEALTH)
			score += _calculate_score(50, combo, difficulty)
			good += 1
			combo += 1
		RhythmBar.Judgement.MISS:
			health = clamp(health - 0.1, 0, BASE_HEALTH)
			miss += 1
			combo = 0
			
	boss_health -= _calculate_damage(judgement)
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
