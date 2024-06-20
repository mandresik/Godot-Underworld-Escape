extends Node2D

var spawning_points := []
var spawn_amount : int

@onready var main = get_node("/root/Main")
var goblin_scene := preload("res://scenes/goblin.tscn")


func _ready():
	spawn_amount = Settings.SPAWNED_GOBLINS_AMOUNT
	$Timer.wait_time = Settings.GOBLIN_SPAWNING_TIME
	for x in get_children():
		if x is Marker2D:
			spawning_points.append(x)


func _on_area_2d_body_entered(_body):
	$Timer.start()


func _on_timer_timeout():
	if spawn_amount == 0:
		$Timer.stop()
		return
	
	var goblin = goblin_scene.instantiate()
	var random_spawn = spawning_points.pick_random()
	goblin.position = position + random_spawn.position
	main.add_child(goblin)
	spawn_amount -= 1
