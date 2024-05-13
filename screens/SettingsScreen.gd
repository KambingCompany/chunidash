extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_update_values()
	
	var minuses = [
		[$"MarginContainer/VSplitContainer/Master Volume/VSplitContainer/HSplitContainer/Minus", "master_volume"],
		[$"MarginContainer/VSplitContainer/SFX Volume/VSplitContainer/HSplitContainer/Minus", "sfx_volume"],
		[$"MarginContainer/VSplitContainer/Music Volume/VSplitContainer/HSplitContainer/Minus", "song_volume"],
		[$MarginContainer/VSplitContainer/Offset/VSplitContainer/HSplitContainer/Minus, "offset"],
	]
	for btn in minuses:
		btn[0].pressed.connect(_on_minus_pressed.bind(btn[1]))
	
	var pluses = [
		[$"MarginContainer/VSplitContainer/Master Volume/VSplitContainer/HSplitContainer/Plus", "master_volume"],
		[$"MarginContainer/VSplitContainer/SFX Volume/VSplitContainer/HSplitContainer/Plus", "sfx_volume"],
		[$"MarginContainer/VSplitContainer/Music Volume/VSplitContainer/HSplitContainer/Plus", "song_volume"],
		[$MarginContainer/VSplitContainer/Offset/VSplitContainer/HSplitContainer/Plus, "offset"],
	]
	for btn in pluses:
		btn[0].pressed.connect(_on_plus_pressed.bind(btn[1]))	

func _update_values():
	$"MarginContainer/VSplitContainer/Master Volume/VSplitContainer/HSplitContainer/Label".text = str(UserSettings.master_volume)
	$"MarginContainer/VSplitContainer/SFX Volume/VSplitContainer/HSplitContainer/Label".text = str(UserSettings.sfx_volume)
	$"MarginContainer/VSplitContainer/Music Volume/VSplitContainer/HSplitContainer/Label".text = str(UserSettings.song_volume)
	$"MarginContainer/VSplitContainer/Offset/VSplitContainer/HSplitContainer/Label".text = str(UserSettings.offset)

func _on_plus_pressed(attrib: String) -> void:
	var new_value = UserSettings.get(attrib) + 10
	if attrib != "offset":
		new_value = min(new_value, 100)
		
	UserSettings.set(attrib, new_value)
	_update_values()

func _on_minus_pressed(attrib: String) -> void:
	var new_value = UserSettings.get(attrib) - 10
	if attrib != "offset":
		new_value = max(new_value, 0)
		
	UserSettings.set(attrib, new_value)
	_update_values()
