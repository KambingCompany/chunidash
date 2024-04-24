extends PanelContainer

var score: Label
var health: ProgressBar
var combo: Label

# Called when the node enters the scene tree for the first time.
func _ready():
	GameState.on_death.connect(on_player_death)
	score = find_child("Score")
	combo = find_child("Combo")
	health = find_child("HealthBar")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GameState.alive:
		score.text = "%010d" % GameState.score
		combo.text = "x%d" % GameState.combo
		health.value = GameState.health

func on_player_death():
	pass
