extends Button


var settings_screen = preload("res://screens/SettingsScreen.tscn")

func _on_pressed() -> void:
	Game.set_screen(settings_screen.instantiate())

