extends Ball

func _init():
	price = 180.0

func _ready():
	add_to_group("ball")
	
	var ball_blue_speed = preload("res://scenes/ball/ballBlue.tscn").instantiate().speed
	
	speed = ball_blue_speed * (35.0 / 50.0)
	health = 200.0
	
	deduct_coins()
