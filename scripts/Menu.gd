extends Control

@onready var player = get_node("/root/Main/Player")
@onready var bullet_manager = get_node("/root/Main/BulletManager")

var increasing_speed_counter : int 
var increasing_damage_counter : int 


func _ready():
	increasing_speed_counter = 0
	increasing_damage_counter = 0
	process_mode = Node.PROCESS_MODE_ALWAYS


func _input(event):
	pass
	

func _on_btn_1_bullets_button_down():
	var amount : int = int($CanvasLayer/Panel/ShopPanel/amountText.text)
	if player.coins >= amount:
		player.subtract_coins(amount)
		player.add_bullets(amount)


func _on_btn_2_health_button_down():
	if player.coins >= Settings.COST_HEALTH:
		player.subtract_coins(Settings.COST_HEALTH)
		player.add_health(1)


func _on_btn_3_overall_speed_button_down():
	if player.coins >= Settings.COST_OVERALL_SPEED:
		player.subtract_coins(Settings.COST_OVERALL_SPEED)
		player.increase_overall_speed()
		increasing_speed_counter += 1
		if(increasing_speed_counter == Settings.MAX_SPEED_INCREMENT_COUNT):
			$CanvasLayer/Panel/ShopPanel/Btn_3_Overall_Speed.disabled = true
			$CanvasLayer/Panel/ShopPanel/Btn_3_Overall_Speed.visible = false

func _on_btn_4_speed_boost_button_down():
	if player.coins >= Settings.COST_SPEED_BOOST:
		player.subtract_coins(Settings.COST_SPEED_BOOST)
		player.add_item_speed(1)


func _on_btn_5_bullet_damage_button_down():
	if player.coins >= Settings.COST_BULLET_DAMAGE:
		player.subtract_coins(Settings.COST_BULLET_DAMAGE)
		bullet_manager.increase_damage()
		increasing_damage_counter += 1
		if increasing_damage_counter == Settings.MAX_BULLET_DAMAGE_INCREMENT_COUNT:
			$CanvasLayer/Panel/ShopPanel/Btn_5_Bullet_damage.disabled = true
			$CanvasLayer/Panel/ShopPanel/Btn_5_Bullet_damage.visible = false


func _on_btn_6_fire_boost_button_down():
	if player.coins >= Settings.COST_FIRE_BOOST:
		player.subtract_coins(Settings.COST_FIRE_BOOST)
		player.add_item_shots(1)
