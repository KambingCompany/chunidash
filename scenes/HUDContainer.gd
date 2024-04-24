extends PanelContainer

var health: Label
var score: Label
var accuracy: Label
var combo: Label

# Called when the node enters the scene tree for the first time.
func _ready():
	GameState.on_death.connect(on_player_death)
	health = find_child("Health")
	score = find_child("Score")
	accuracy = find_child("Accuracy")
	combo = find_child("Combo")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GameState.alive:
		health.text = "Health: %.1f" % GameState.health
		score.text = "Score: %d" % GameState.score
		accuracy.text = "Accuracy: %.2f" % (GameState.accuracy * 100)
		combo.text = "Combo: %d" % GameState.combo

func on_player_death():
	health.text = "DEAD"
