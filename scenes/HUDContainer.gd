extends PanelContainer

var score: Label
var health: ProgressBar
var combo: Label

var boss_health_bar: ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready():
	GameState.on_death.connect(on_player_death)
	score = find_child("Score")
	combo = find_child("Combo")
	health = find_child("HealthBar")
	boss_health_bar = find_child("BossHealthBar")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GameState.alive:
		score.text = "%010d" % GameState.score
		combo.text = "x%03d" % GameState.combo
		health.value = GameState.health
		boss_health_bar.value = (GameState.boss_health / GameState.initial_boss_health) * 100

func on_player_death():
	pass
