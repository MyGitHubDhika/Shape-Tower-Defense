extends Node

const ball_blue = preload("res://scenes/ball/ballBlue.tscn")
const ball_yellow = preload("res://scenes/ball/ballYellow.tscn")

const square_red = preload("res://scenes/square/squareRed.tscn")
const square_thunder = preload("res://scenes/square/squareThunder.tscn")

func _ready():
	add_to_group("level")
	
	spawn_square(square_red, 0.0, 2.0, 10)
	spawn_square(square_thunder, 4.0, 0.2, 4)
	spawn_square(square_thunder, 14.0, 0.2, 4)
	
	display_coins()

@onready var label_coins = %LabelCoins

func _process(delta):
	if Input.is_action_just_pressed("spawn_ball_1"):
		spawn_ball(ball_blue)
	
	if Input.is_action_just_pressed("spawn_ball_2"):
		spawn_ball(ball_yellow)
		
	label_coins.text = "Coins: " + str(coins)
		
func spawn_ball(unit_scene) -> void:
	var ball = unit_scene.instantiate()
	add_child(ball)
	ball.position = Vector2(1040.0, 330.0)

func spawn_square(square_scene, start_delay = 0.0, delay = 0.0, max_spawn = 1) -> void:
	await get_tree().create_timer(start_delay).timeout
	
	for i in range(max_spawn):
		var square = square_scene.instantiate()
		add_child(square)
		square.position = Vector2(125.0, 330.0)
		
		await get_tree().create_timer(delay).timeout
		
var coins = 0

func display_coins():
	while true:
		await get_tree().create_timer(0.05).timeout
		coins += 3
	
