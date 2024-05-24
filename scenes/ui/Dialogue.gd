extends Control

# Called when the node enters the scene tree for the first time.
func start_dialogue(dialogue_file_name):
	var dialogue_file = load("res://dialogues/" + dialogue_file_name + ".dialogue")
	
	var background_image: Texture2D = null
	for image in DirAccess.get_files_at("res://assets/dialogue_backgrounds"):
		if image.begins_with(dialogue_file_name) and not ".import" in image:
			background_image = load("res://assets/dialogue_backgrounds/" + image)
	
	DialogueManager.dialogue_ended.connect(_on_dialog_ended)
	DialogueManager.show_dialogue_balloon(dialogue_file, dialogue_file_name)
	$TextureRect.texture = background_image

func _on_dialog_ended(_resource):
	queue_free()
