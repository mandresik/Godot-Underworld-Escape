extends Node2D

@export var bullet_scene : PackedScene
@export var skull_bullet_scene : PackedScene
@export var fast_skull_bullet_scene : PackedScene

var damage : int 


func _ready():
	damage = Settings.INIT_BULLET_DAMAGE


func increase_damage():
	damage += 1


func _on_player_shooting(pos, dir):
	var bullet = bullet_scene.instantiate()
	bullet.damage = damage
	bullet.position = pos
	bullet.direction = dir.normalized()
	call_deferred("add_child", bullet)


func shoot_skull(pos, dir, speed):
	var skull_bullet = skull_bullet_scene.instantiate()
	skull_bullet.speed = speed
	skull_bullet.position = pos
	skull_bullet.direction = dir.normalized()
	call_deferred("add_child", skull_bullet)


func _on_boss_w_shooting_skull(pos, dir):
	shoot_skull(pos, dir, Settings.BOSS_W_SKULL_SPEED)

func _on_boss_s_shooting_skull(pos, dir):
	shoot_skull(pos, dir, Settings.BOSS_S_SKULL_SPEED)

func _on_boss_e_shooting_skull(pos, dir):
	shoot_skull(pos, dir, Settings.BOSS_E_SKULL_SPEED)

func _on_main_boss_n_shooting_skull(pos, dir):
	shoot_skull(pos, dir, Settings.BOSS_N_SKULL_SPEED)
