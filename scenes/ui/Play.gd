extends Button

@onready var level_select = load("res://screens/LevelSelect.tscn")

func _on_pressed():	
	Game.set_screen(level_select.instantiate())
