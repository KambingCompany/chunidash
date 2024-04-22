extends Control

class_name ProjectileController

var projectiles: Array[Projectile] = []
var current_time = 0

func _process(delta: float) -> void:
	var i = 0
	while true:
		if i >= len(projectiles):
			break

		var projectile = projectiles[i]
		if not is_instance_valid(projectile):
			projectiles.remove_at(i)
			continue
		
		if projectile.start_time > current_time + 2000:
			break
		
		if not projectile.is_inside_tree():
			add_child(projectile)

		projectile.execute_commands(current_time)
		i += 1
