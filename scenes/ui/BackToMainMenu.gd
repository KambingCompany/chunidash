extends Button

func _on_pressed():
	Game.change_scene_to_packed(load("res://screens/LevelSelect.tscn"))
