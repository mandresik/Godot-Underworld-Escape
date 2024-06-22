extends Area2D

var speed : int # speed is set in the Bullet Manager
var damage : int
var direction : Vector2


func _ready():
	# speed = 270 
	damage = 1
	$AnimatedSprite2D.play()


func _process(delta):
	$AnimatedSprite2D.flip_h = direction.x < 0
	position += speed * direction * delta


func _on_body_entered(body):
	if body.name == "World" or body is StaticBody2D:
		queue_free()
		return
	
	body.subtract_health(damage)
	queue_free()
