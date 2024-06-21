extends Area2D

var peaks_active : bool
var in_hurting_area : bool
var inactive_time : float
var animations := []

@onready var player = get_node("/root/Main/Player")

# animation is set NOT to loop, timer handles looping

func _ready():
	peaks_active = false
	in_hurting_area = false
	inactive_time = Settings.INACTIVE_PEAKS_TIME
	for x in get_children():
		if x is AnimatedSprite2D:
			animations.append(x)
	
	$DeactivePeaksTimer.wait_time = inactive_time
	$DeactivePeaksTimer.start()


func _on_body_entered(body):
	in_hurting_area = true
	if peaks_active: 
		hurt()


func _on_body_exited(body):
	in_hurting_area = false


func _on_animated_sprite_2d_animation_finished():
	peaks_active = false
	$DeactivePeaksTimer.start()


func _on_deactive_peaks_timer_timeout():
	peaks_active = true
	for x in animations:
		x.play()
	if in_hurting_area:
		hurt()


func hurt():
	player.subtract_health(1)



