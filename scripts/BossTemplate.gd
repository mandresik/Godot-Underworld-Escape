extends CharacterBody2D

var active : bool
var speed : int
var health : int
var direction : Vector2
var retreating : bool
var retreating_speed : int
var init_bullets_in_clip : int 
var curr_bullets_in_clip : int

@onready var main = get_node("/root/Main")
@onready var player = get_node("/root/Main/Player")

var key_scene := preload("res://scenes/golden_key.tscn")

signal shooting_skull


func _ready():
	active = false
	speed = 170
	health = 5
	direction = Vector2.ZERO
	retreating = false
	init_bullets_in_clip = 1
	curr_bullets_in_clip = init_bullets_in_clip
	retreating_speed = Settings.MINIBOSS_RETREATING_SPEED
	$RetreatingTimer.wait_time = Settings.MINIBOSS_RETREAT_TIME
	$AnimatedSprite2D.play("idle")
	$IntraClipTimer.wait_time = 1
	$ReloadingClipTimer.wait_time = 3


func _physics_process(_delta):
	if active:
		direction = player.position - position
		if retreating: 
			direction *= -1
		direction = direction.normalized()
		velocity = direction * (speed if !retreating else retreating_speed)
		move_and_slide()
		
		if velocity.x != 0:
			$AnimatedSprite2D.flip_h = velocity.x < 0
		# keep eyes on player if fighting
		if retreating:
			$AnimatedSprite2D.flip_h = player.position.x < position.x



func shoot_skull_bullet():
	var aim_direction = player.position - position
	shooting_skull.emit(position, aim_direction)



func _on_wake_up_area_2d_body_entered(_body):
	# interacts only with player
	active = true
	$AnimatedSprite2D.play("run")
	shoot()


func _on_contact_area_2d_body_entered(_body):
	# interacts only with player
	player.subtract_health(1)
	retreating = true
	$RetreatingTimer.start()


func _on_retreating_timer_timeout():
	retreating = false


func _on_intra_clip_timer_timeout():
	shoot()


func _on_reloading_clip_timer_timeout():
	shoot()


func shoot():
	curr_bullets_in_clip -= 1
	shoot_skull_bullet()
	if curr_bullets_in_clip == 0:
		curr_bullets_in_clip = init_bullets_in_clip
		$ReloadingClipTimer.start()
	else:
		$IntraClipTimer.start()


func die(): 
	var key = key_scene.instantiate()
	key.position = position
	main.call_deferred("add_child", key)
	queue_free()


