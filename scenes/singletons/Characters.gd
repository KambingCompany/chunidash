extends Node

var CHARACTER_SPRITES = {
	"DIKCY": preload("res://assets/characters/dikcy.png"),
	"FREAKCY": preload("res://assets/characters/freakcy.png"),
	"MEMETIUS": preload("res://assets/songs/mopemope/Boss/Memetius.png"),
	"PROMETHEUS": preload("res://assets/characters/prometheus.png")
}

func get_character_sprite(name: String):
	return CHARACTER_SPRITES.get(name)
