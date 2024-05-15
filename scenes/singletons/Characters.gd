extends Node

var CHARACTER_SPRITES = {
	"DIKCY": preload("res://assets/characters/dikcy.png"),
	"DIKCY?": preload("res://assets/characters/freakcy.png"),
	"MEMETIUS": preload("res://assets/songs/mopemope/Boss/Memetius.png")
}

func get_character_sprite(name: String):
	return CHARACTER_SPRITES[name]
