extends Ball

func _init():
	price = 100.0

func _ready():
	add_to_group("ball")
	
	speed = 70.0
	health = 100.0
	
	deduct_coins()
