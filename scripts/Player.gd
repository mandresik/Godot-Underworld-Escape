extends CharacterBody2D

var speed : int
var shot_cooldown : float
var can_shoot : bool
var health : int
var bullet_count : int

signal shooting


func _ready():
	speed = Settings.INIT_PLAYER_SPEED
	can_shoot = true
	$ShootingTimer.wait_time = Settings.INIT_SHOT_COOLDOWN
	health = Settings.INIT_HEALTH
	bullet_count = Settings.INIT_BULLET_COUNT


func _physics_process(_delta):
	# player movement
	handle_keyboard_movement()
	# player rotation 
	handle_mouse_rotation()
	# player shooting
	handle_mouse_click()


func handle_keyboard_movement():
	# keyboard movement input
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction.normalized() * speed 
	move_and_slide()


func handle_mouse_rotation():
	var mouse = get_local_mouse_position()
	var angle = snappedf(mouse.angle(), PI / 4) / (PI / 4)
	angle = wrapi(int(angle), 0, 8)
	# player animation
	$AnimatedSprite2D.animation = "walk" + str(angle)
	if velocity.length() != 0:
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		$AnimatedSprite2D.frame = 1


func handle_mouse_click():
	if bullet_count > 0:
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and can_shoot:
			var aim_direction = get_global_mouse_position() - position
			shooting.emit(position, aim_direction)
			can_shoot = false
			$ShootingTimer.start()
			bullet_count -= 1


func _on_shooting_timer_timeout():
	can_shoot = true



