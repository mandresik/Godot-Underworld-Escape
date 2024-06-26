extends CharacterBody2D

var speed : int
var shot_cooldown : float
var can_shoot : bool
var health : int
var bullet_count : int

var coins : int = 0
var keys : int = 0
var item_health_amount : int = 0
var item_speed_amount : int = 0
var item_shots_amount : int = 0

# signal shooting is emitted to BulletManager
signal shooting 
# signals emitting to Panel
signal bullet_count_change 
signal item_amount_change 
signal health_change
signal coins_amount_change 
signal key_count_change


func _ready():
	speed = Settings.INIT_PLAYER_SPEED
	can_shoot = true
	$ShootingTimer.wait_time = Settings.INIT_SHOT_COOLDOWN
	health = Settings.INIT_HEALTH
	bullet_count = Settings.INIT_BULLET_COUNT
	$BoostSpeedTimer.wait_time = Settings.BOOST_SPEED_TIME
	$BoostShotsTimer.wait_time = Settings.BOOST_SHOTS_TIME

func _physics_process(_delta):
	# player movement
	handle_keyboard_movement()
	# player boosting
	handle_keyboard_boosting()
	# player rotation 
	handle_mouse_rotation()
	# player shooting
	handle_mouse_click()


func handle_keyboard_movement():
	# keyboard movement input
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction.normalized() * speed 
	move_and_slide()


func handle_keyboard_boosting():
	if Input.is_action_just_pressed("key_boost_health"):
		boost_health()
	if Input.is_action_just_pressed("key_boost_speed"):
		boost_speed_effect()
	if Input.is_action_just_pressed("key_boost_shots"):
		boost_shots_effect()


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
			bullet_count_change.emit(bullet_count)


func _on_shooting_timer_timeout():
	can_shoot = true


func emit_item_amount_change():
	item_amount_change.emit(item_health_amount, item_speed_amount, item_shots_amount)


func subtract_health(amount: int):
	health -= amount
	health_change.emit(health)
	if health == 0:
		die()


func boost_health():
	if item_health_amount > 0: 
		health += 1
		item_health_amount -= 1
		health_change.emit(health)
		emit_item_amount_change()


var prev_speed : int
func boost_speed_effect():
	if item_speed_amount > 0:
		item_speed_amount -= 1
		emit_item_amount_change()
		prev_speed = speed
		speed = Settings.PLAYER_MAX_SPEED
		$BoostSpeedTimer.start()


func _on_boost_speed_timer_timeout():
	speed = prev_speed


func boost_shots_effect():
	if item_shots_amount > 0:
		item_shots_amount -= 1
		emit_item_amount_change()
		$ShootingTimer.wait_time = Settings.BEST_SHOT_COOLDOWN
		$BoostShotsTimer.start()


func _on_boost_shots_timer_timeout():
	$ShootingTimer.wait_time = Settings.INIT_SHOT_COOLDOWN


func increase_overall_speed():
	speed += Settings.PLAYER_SPEED_INCREMENT


func add_coins(amount: int):
	coins += amount
	coins_amount_change.emit(coins)


func subtract_key(count : int):
	keys -= count
	key_count_change.emit(keys)


func add_key(count: int): subtract_key(-count)


func subtract_coins(amount: int): add_coins(-amount)


func add_bullets(amount: int):
	bullet_count += amount
	bullet_count_change.emit(bullet_count)


func add_health(amount: int): subtract_health(-amount)


func add_item_speed(amount: int):
	item_speed_amount += amount
	emit_item_amount_change()


func add_item_shots(amount: int):
	item_shots_amount += amount
	emit_item_amount_change()


func die():
	print("game over")
	call_deferred("restart_game")


func restart_game():
	get_tree().reload_current_scene()



