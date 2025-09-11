extends Square

func _ready():
	add_to_group('square')
	
	var ball_blue_speed = preload("res://scenes/ball/ballBlue.tscn").instantiate().speed
	
	speed = ball_blue_speed * (75.0 / 50.0)
	health = 75.0
	coins_drop = 50
