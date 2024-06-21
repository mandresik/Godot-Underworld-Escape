extends Node2D

@export var bullet_scene : PackedScene
@export var skull_bullet_scene : PackedScene



func _on_player_shooting(pos, dir):
	var bullet = bullet_scene.instantiate()
	bullet.position = pos
	bullet.direction = dir.normalized()
	add_child(bullet)


func _on_bosses_shooting_skull(pos, dir):
	var skull_bullet = skull_bullet_scene.instantiate()
	skull_bullet.position = pos
	skull_bullet.direction = dir.normalized()
	call_deferred("add_child", skull_bullet)
