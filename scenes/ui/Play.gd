extends LinkButton

var loading_scene = preload("res://screens/LoadingScreen.tscn")

func _on_pressed():
	print("Wee")
	GameState.start_new_game(GameState.Difficulty.EASY)
	var loading = loading_scene.instantiate()
	loading.song = SongList.getSongs()[0]
	
	Game.set_screen(loading)
