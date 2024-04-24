extends PanelContainer

var score: Label
var miss: Label
var good: Label
var great: Label
var perfect: Label
var combo: Label
var hp: Label

# Called when the node enters the scene tree for the first time.
func _ready():
	score = find_child("Score")
	miss = find_child("Miss")
	good = find_child("Good")
	great = find_child("Great")
	perfect = find_child("Perfect")
	combo = find_child("Combo")
	hp = find_child("HP")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	score.text = "%010d" % GameState.score
	miss.text = "Miss %d" % GameState.miss
	good.text = "Good %d" % GameState.good
	great.text = "Great %d" % GameState.great
	perfect.text = "Perfect %d" % GameState.perfect
	combo.text = "Combo %d" % GameState.combo
	hp.text = "HP %d" % GameState.health
