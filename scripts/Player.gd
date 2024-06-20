extends CharacterBody2D

var speed : int



func _ready():
	speed = Settings.INIT_SPEED


func _physics_process(_delta):
	# player movement
	get_input()
	move_and_slide()
	# player rotation 
	var mouse = get_local_mouse_position()
	var angle = snappedf(mouse.angle(), PI / 4) / (PI / 4)
	angle = wrapi(int(angle), 0, 8)
	$AnimatedSprite2D.animation = "walk" + str(angle)
	# player animation
	if velocity.length() != 0:
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		$AnimatedSprite2D.frame = 1


func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction.normalized() * speed 
