extends Node

# load the scenes
const ball_blue = preload("res://scenes/ball/ballBlue.tscn")
const ball_yellow = preload("res://scenes/ball/ballYellow.tscn")
const ball_nature = preload("res://scenes/ball/ballNature.tscn")

const square_red = preload("res://scenes/square/squareRed.tscn")
const square_thunder = preload("res://scenes/square/squareThunder.tscn")
const square_rock = preload("res://scenes/square/squareRock.tscn")

# to make it easier to organize and to spawn a ball
var balls = [ball_blue, ball_yellow, ball_nature]

var activated = true # if the game is allowed to run
@export var time_scale = 1.0 # time multiplier

func _ready():
	Engine.time_scale = time_scale # set the time multiplier
	
	add_to_group("level")
	
	# spawn the squares
	spawn_square(square_red, 0.0, 2.0, 15)
	spawn_square(square_thunder, 4.0, 0.2, 4)
	spawn_square(square_thunder, 20.0, 0.2, 4)
	spawn_square(square_rock, 6.0)
	spawn_square(square_rock, 22.0)
	
	add_coins()

# set the value of labels
@onready var label_coins = %LabelCoins
@onready var label_base_health = %LabelBaseHealth
@onready var label_enemy_health = %LabelEnemyHealth

# PanelYouWin and PanelYouLose pop-up
@onready var panel_you_win = %PanelYouWin
@onready var panel_you_lose = %PanelYouLose

# screen width and height
@onready var screen_width = get_viewport().size.x
@onready var screen_height = get_viewport().size.y

@export var base_health = 500
@export var enemy_health = 500
func _process(_delta):
	
	# Keybinds to spawn a ball
	if activated:
		if Input.is_action_just_pressed("spawn_ball_1"):
			spawn_ball(balls[0])
		
		if Input.is_action_just_pressed("spawn_ball_2"):
			spawn_ball(balls[1])
			
		if Input.is_action_just_pressed("spawn_ball_3"):
			spawn_ball(balls[2])
		
	label_coins.text = "Coins: " + str(coins) # updates coins value
	label_base_health.text = "Base Health: " + str(base_health) # updates base health
	label_enemy_health.text = "Enemy Health: " + str(enemy_health) # updates enemy health
	
	if base_health <= 0: # if the base is destroyed (losing)
		label_base_health.text = "Base Health: 0"
		
		# pop-ups PanelYouLose to the center of the screen
		var panel_you_lose_width = panel_you_lose.size.x / 2
		var panel_you_lose_height = panel_you_lose.size.y / 2
		panel_you_lose.position = Vector2((screen_width / 2) - panel_you_lose_width, (screen_height / 2) - panel_you_lose_height)
		
		activated = false
	
	if enemy_health <= 0: # if the enemy's base is destroyed (winning)
		label_enemy_health.text = "Enemy Health: 0"
		
		# pop-ups PanelYouWin to the center of the screen
		var panel_you_win_width = panel_you_win.size.x / 2
		var panel_you_win_height = panel_you_win.size.y / 2
		panel_you_win.position = Vector2((screen_width / 2) - panel_you_win_width, (screen_height / 2) - panel_you_win_height)
		
		activated = false

# spawn a ball
func spawn_ball(unit_scene) -> void:
	var ball = unit_scene.instantiate()
	add_child(ball)
	ball.position = Vector2(1040.0, 330.0)

# spawn a group of squares based on interval and amount
func spawn_square(square_scene, start_delay = 0.0, delay = 0.0, max_spawn = 1) -> void:
	await get_tree().create_timer(start_delay).timeout
	
	for i in range(max_spawn):
		if activated:
			var square = square_scene.instantiate()
			add_child(square)
			square.position = Vector2(125.0, 330.0)
			
			await get_tree().create_timer(delay).timeout
		
var coins = 0
func add_coins(): # updates coins value by a small amount
	while true:
		if not activated:
			break
			
		await get_tree().create_timer(0.05).timeout
		coins += 2

func _on_button_1_pressed(): # the 1st button on PanelEquipButton to spawn a ball
	if activated:
		spawn_ball(balls[0])

func _on_button_2_pressed(): # the 2nd button on PanelEquipButton to spawn a ball
	if activated:
		spawn_ball(balls[1])

func _on_button_3_pressed(): # the 3rd button on PanelEquipButton to spawn a ball
	if activated:
		spawn_ball(balls[2])
