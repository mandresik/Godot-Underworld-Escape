extends Area2D


func restart():
	get_tree().reload_current_scene()

func _on_body_entered(_body):
	restart()
