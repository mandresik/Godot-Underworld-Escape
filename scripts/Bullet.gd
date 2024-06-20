extends Area2D

var speed : int
var damage : int
var direction : Vector2


func _ready():
	speed = Settings.INIT_BULLET_SPEED
	damage = Settings.INIT_BULLET_DAMAGE


func _process(delta):
	position += speed * direction * delta


func _on_body_entered(_body):
	# TODO handle what bullet hits
	queue_free()
