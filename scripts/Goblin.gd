extends CharacterBody2D

var active : bool 
var speed : int
var direction : Vector2

@onready var main = get_node("/root/Main")
@onready var player = get_node("/root/Main/Player")


func _ready():
	active = false
	speed = Settings.INIT_GOBLIN_SPEED
	$AnimatedSprite2D.animation = "idle"
	$IdleTimer.wait_time = Settings.GOBLIN_IDLE_TIME
	$IdleTimer.start()


func _physics_process(_delta):
	if active:
		direction = player.position - position
		direction = direction.normalized()
		velocity = direction * speed
		move_and_slide()
		
		if velocity.x != 0:
			$AnimatedSprite2D.flip_h = velocity.x < 0


func _on_idle_timer_timeout():
	$AnimatedSprite2D.animation = "run"
	active = true
