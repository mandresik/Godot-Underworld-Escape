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
	# interacts only with player
	if item_type == 0: body.item_health_amount += 1
	if item_type == 1: body.item_speed_amount += 1
	if item_type == 2: body.item_shots_amount += 1
	body.emit_item_amount_change()
	queue_free()
