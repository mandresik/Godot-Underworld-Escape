extends Area2D

# 0: health, 1: coffee, 2: gun
var item_type : int

var health_box = preload("res://assets/items/health_box.png")
var coffee_box = preload("res://assets/items/coffee_box.png")
var gun_box = preload("res://assets/items/gun_box.png")
var textures = [health_box, coffee_box, gun_box]

func _ready():
	item_type = randi() % 3
	$Sprite2D.texture = textures[item_type]


func _on_body_entered(body):
	# TODO item_type -> body.some_action()
	queue_free()
