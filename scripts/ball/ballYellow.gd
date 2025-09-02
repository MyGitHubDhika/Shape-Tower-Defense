extends Ball

func _ready():
	add_to_group("ball")
	
	var ball_blue_speed = preload("res://scenes/ball/ballBlue.tscn").instantiate().speed
	
	speed = ball_blue_speed * (100.0 / 50.0)
	health = 50.0
	price = 60.0
	
	deduct_money()
