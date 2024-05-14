extends Control

# Called when the node enters the scene tree for the first time.
func start_dialogue(dialogue_file_name):
	var dialogue_file = load("res://dialogues/" + dialogue_file_name + ".dialogue")
	DialogueManager.dialogue_ended.connect(_on_dialog_ended)
	DialogueManager.show_dialogue_balloon(dialogue_file, dialogue_file_name)

func _on_dialog_ended(_resource):
	queue_free()
