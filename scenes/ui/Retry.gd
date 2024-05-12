extends Button

var loading_scene = preload("res://screens/LoadingScreen.tscn")

func _on_pressed():
	GameState.start_new_game(GameState.Difficulty.EASY)
	var loading = loading_scene.instantiate()
	loading.song = GameState.current_song
	
	Game.set_screen(loading)
