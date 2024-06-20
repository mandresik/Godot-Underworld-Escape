extends Node2D

@export var bullet_scene: PackedScene



func _on_player_shooting(pos, dir):
	var bullet = bullet_scene.instantiate()
	add_child(bullet)
	bullet.position = pos
	bullet.direction = dir.normalized()
	# bullet.add_to_group("bullets")
