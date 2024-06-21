extends Area2D

var speed : int
var damage : int  # set in Bullet Manager
var direction : Vector2  # set in Bullet Manager


func _ready():
	speed = Settings.INIT_BULLET_SPEED


func _process(delta):
	position += speed * direction * delta


func _on_body_entered(body):
	if body.name == "World" or body is StaticBody2D:
		queue_free()
		return
	# stronger from bullet vs body survives
	if body.health == damage:
		body.die()
		queue_free()
	elif body.health > damage:
		body.health -= damage
		queue_free()
	else:
		damage -= body.health
		body.die()
