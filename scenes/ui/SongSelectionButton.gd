extends Button

var loading_scene = preload("res://screens/LoadingScreen.tscn")

@export var song: Song
@export var background: Texture2D
@export var title: String

# Called when the node enters the scene tree for the first time.
func _ready():
	$Background.texture = background
	self.text = title


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_focus_entered():
	$ColorRect.color = "#00000032"


func _on_focus_exited():
	$ColorRect.color = "#00000096"


func _on_pressed():
	GameState.start_new_game(GameState.Difficulty.EASY)
	var loading = loading_scene.instantiate()
	loading.song = song
	
	Game.set_screen(loading)
