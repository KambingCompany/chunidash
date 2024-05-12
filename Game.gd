extends Node

var current_scene: Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)

func change_scene_to_packed(scene: PackedScene):
	var s = scene.instantiate()
	set_screen(s)

func set_screen(node: Node):
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:

	call_deferred("_deferred_set_screen", node)

func _deferred_set_screen(node: Node):
	current_scene.free()
	current_scene = node
	get_tree().root.add_child(node)
	get_tree().current_scene = current_scene
