extends Area2D



func _on_body_entered(body):
	# interacts only with player
	if body.keys > 0:
		body.subtract_key()
		queue_free()
