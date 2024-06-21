extends Area2D


func _ready():
	$AnimatedSprite2D.play()


func _on_body_entered(body):
	# interacts only with player
	body.add_key(1)
	queue_free()
