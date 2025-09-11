extends Node

const ball_blue = preload("res://scenes/ball/ballBlue.tscn")
const ball_yellow = preload("res://scenes/ball/ballYellow.tscn")
const ball_nature = preload("res://scenes/ball/ballNature.tscn")

const square_red = preload("res://scenes/square/squareRed.tscn")
const square_thunder = preload("res://scenes/square/squareThunder.tscn")
const square_rock = preload("res://scenes/square/squareRock.tscn")

var balls = [ball_blue, ball_yellow, ball_nature]

func _ready():
	add_to_group("level")
	
	spawn_square(square_red, 0.0, 2.0, 15)
	spawn_square(square_thunder, 4.0, 0.2, 4)
	spawn_square(square_thunder, 20.0, 0.2, 4)
	spawn_square(square_rock, 6.0)
	spawn_square(square_rock, 22.0)
	
	display_coins()

@onready var label_coins = %LabelCoins
@onready var label_base_health = %LabelBaseHealth

var base_health = 500
func _process(_delta):
	if Input.is_action_just_pressed("spawn_ball_1"):
		spawn_ball(balls[0])
	
	if Input.is_action_just_pressed("spawn_ball_2"):
		spawn_ball(balls[1])
		
	if Input.is_action_just_pressed("spawn_ball_3"):
		spawn_ball(balls[2])
		
	label_coins.text = "Coins: " + str(coins)
	label_base_health.text = "Base Health: " + str(base_health)
	
	if base_health <= 0:
		label_base_health.text = "Base Health: 0"
		Engine.time_scale = 0.0
		
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
		coins += 2
	
func _on_button_1_pressed():
	spawn_ball(balls[0])

func _on_button_2_pressed():
	spawn_ball(balls[1])

func _on_button_3_pressed():
	spawn_ball(balls[2])
