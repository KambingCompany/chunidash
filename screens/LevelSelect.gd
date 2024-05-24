extends PanelContainer

var song_button_template = preload("res://scenes/ui/SongSelectionButton.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var tutorial_button = song_button_template.instantiate()
	tutorial_button.title = SongList.tutorial.artist + " - " + SongList.tutorial.title
	tutorial_button.background = SongList.tutorial.level_image
	tutorial_button.song = SongList.tutorial
	$MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/VBoxContainer.add_child(tutorial_button)
	
	for song in SaveManager.get_unlocked_songs():
		var song_button = song_button_template.instantiate()
		if song:
			song_button.title = song.artist + " - " + song.title
			song_button.background = song.level_image
		song_button.song = song
		$MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/VBoxContainer.add_child(song_button)
		
	var button_els = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/VBoxContainer.get_children()
	for i in range(1, len(button_els)):
		button_els[i-1].set_focus_neighbor(SIDE_BOTTOM, button_els[i].get_path()) 
		button_els[i].set_focus_neighbor(SIDE_TOP, button_els[i-1].get_path())
	
	button_els[0].grab_focus()
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
