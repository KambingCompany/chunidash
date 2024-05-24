extends Node

var SAVE_PATH = "user://chunidash.save"
var current_progress = 0

func save_game():
	var save_dict = {
		"current_progress": current_progress 
	}
	
	var save_game = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	save_game.store_string(
		JSON.stringify(save_dict)
	)
	
func load_game():
	if not FileAccess.file_exists(SAVE_PATH):
		print("NO SAVE FILE EXISTS")
		return
	
	var save_game = FileAccess.open(SAVE_PATH, FileAccess.READ)
	
	var save_data = save_game.get_line()
	var json = JSON.new()
	var parsed_save = json.parse_string(save_data)

	if parsed_save:
		current_progress = parsed_save.get("current_progress")
	
	print(current_progress)

# Called when the node enters the scene tree for the first time.
func _ready():	
	load_game()

func increment_progress(song: Song):
	if current_progress == song.song_index:
		current_progress += 1
	save_game()

func get_unlocked_songs():
	var songs = SongList.getSongs()
	var unlocked_songs = []
	for i in range(len(songs)):
		if current_progress >= i:
			unlocked_songs.append(songs[i])
		else:
			unlocked_songs.append(null)
	
	return unlocked_songs
	
