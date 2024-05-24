extends Button

var loading_screen = preload("res://screens/LoadingScreen.tscn")

func _on_pressed() -> void:
	var loader = loading_screen.instantiate()
	loader.song = SongList.tutorial
	
	Game.set_screen(loader)
