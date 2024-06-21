extends CharacterBody2D

var active : bool 
var speed : int
var health : int
var direction : Vector2

@onready var main = get_node("/root/Main")
@onready var player = get_node("/root/Main/Player")

var item_scene := preload("res://scenes/item.tscn")
var explosion_scene := preload("res://scenes/explosion.tscn")


func _ready():
	active = false
	speed = Settings.INIT_GOBLIN_SPEED
	health = 1
	direction = Vector2.ZERO
	$AnimatedSprite2D.play("idle")
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
	$AnimatedSprite2D.play("run")
	active = true


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		player.subtract_health(1)
		queue_free()


func die():
	player.add_coins(Settings.COINS_FOR_GOBLIN)
	if randf() <= Settings.GOBLIN_DROP_CHANCE: drop_item()
	var explosion = explosion_scene.instantiate()
	explosion.position = position
	main.add_child(explosion)
	explosion.process_mode = Node.PROCESS_MODE_ALWAYS 
	queue_free()


func drop_item():
	var item = item_scene.instantiate()
	item.position = position
	main.call_deferred("add_child", item)
	# item.add_to_group("items")
