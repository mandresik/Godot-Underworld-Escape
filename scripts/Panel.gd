extends CanvasLayer


func _ready():
	$HealthLabel.text = str(Settings.INIT_HEALTH)
	$BoostHealthLabel.text = "0"
	$BoostSpeedLabel.text = "0"
	$BoostShotsLabel.text = "0"
	$BulletsLabel.text = str(Settings.INIT_BULLET_COUNT)
	$CoinsLabel.text = "0"
	$KeysLabel.text = "0"


func _on_player_bullet_count_change(curr_amount: int):
	$BulletsLabel.text = str(curr_amount)


func _on_player_item_amount_change(item_health: int, item_speed: int, item_shots: int):
	$BoostHealthLabel.text = str(item_health)
	$BoostSpeedLabel.text = str(item_speed)
	$BoostShotsLabel.text = str(item_shots)


func _on_player_health_change(curr_amount: int):
	$HealthLabel.text = str(curr_amount)


func _on_player_coins_amount_change(curr_amount: int):
	$CoinsLabel.text = str(curr_amount)
