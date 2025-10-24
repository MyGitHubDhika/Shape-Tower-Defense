extends Node

# load the scenes
const ball_blue = preload("res://scenes/ball/ballBlue.tscn")
const ball_yellow = preload("res://scenes/ball/ballYellow.tscn")
const ball_nature = preload("res://scenes/ball/ballNature.tscn")

const square_red = preload("res://scenes/square/squareRed.tscn")
const square_thunder = preload("res://scenes/square/squareThunder.tscn")
const square_rock = preload("res://scenes/square/squareRock.tscn")

# balls and price displays organizer
var balls = []
var price_displays = []

var activated := true # the game is allowed to run or paused

func _ready():
	add_to_group("level")
	
	balls.resize(6)
	
	balls[0] = ball_blue
	balls[1] = ball_yellow
	balls[2] = ball_nature
	
	price_displays = [price_display_1, price_display_2, price_display_3, price_display_4, price_display_5]
	
	# spawn the squares
	spawn_square(square_red, 0.0, 2.0, 15)
	spawn_square(square_thunder, 4.0, 0.2, 4)
	spawn_square(square_thunder, 20.0, 0.2, 4)
	spawn_square(square_rock, 6.0)
	spawn_square(square_rock, 22.0)
	
	add_coins()
	display_price()

# get the labels
@onready var label_coins = %LabelCoins
@onready var label_base_health = %LabelBaseHealth
@onready var label_enemy_health = %LabelEnemyHealth

# get the pop-up panels.
@onready var panel_you_win = %PanelYouWin
@onready var panel_you_lose = %PanelYouLose

# get the screen width and height
@onready var screen_width = get_viewport().size.x
@onready var screen_height = get_viewport().size.y

# set the base health and enemy base health
@export var base_health := 500
@export var enemy_base_health := 500

# get the price display labels
@onready var price_display_1 = %LabelButton1
@onready var price_display_2 = %LabelButton2
@onready var price_display_3 = %LabelButton3
@onready var price_display_4 = %LabelButton4
@onready var price_display_5 = %LabelButton5
@onready var price_display_6 = %LabelButton6

func _process(_delta):
	
	# Keybinds (1 to 6) to spawn a ball
	if activated:
		if Input.is_action_just_pressed("spawn_ball_1"):
			spawn_ball(balls[0])
		
		if Input.is_action_just_pressed("spawn_ball_2"):
			spawn_ball(balls[1])
			
		if Input.is_action_just_pressed("spawn_ball_3"):
			spawn_ball(balls[2])
		
		if Input.is_action_just_pressed("spawn_ball_4"):
			spawn_ball(balls[3])
			
		if Input.is_action_just_pressed("spawn_ball_5"):
			spawn_ball(balls[4])
			
		if Input.is_action_just_pressed("spawn_ball_6"):
			spawn_ball(balls[5])
		
	label_coins.text = "Coins: " + str(coins) # set the coins' label to the updated valye
	label_base_health.text = "Base Health: " + str(base_health) # set the base health's label to the updated value
	label_enemy_health.text = "Enemy Health: " + str(enemy_base_health) # set the enemy base health's label to the updated value
	
	if base_health <= 0: # if the base is destroyed, aka LOSING
		label_base_health.text = "Base Health: 0"
		
		# pop-ups PanelYouLose to the center of the screen
		var panel_you_lose_width = panel_you_lose.size.x / 2
		var panel_you_lose_height = panel_you_lose.size.y / 2
		panel_you_lose.position = Vector2((screen_width / 2) - panel_you_lose_width, (screen_height / 2) - panel_you_lose_height)
		
		activated = false # pause the game
		time_scale = 1
		Engine.time_scale = 1
	
	if enemy_base_health <= 0: # if the enemy's base is destroyed, aka WINNING
		label_enemy_health.text = "Enemy Health: 0"
		
		# pop-ups PanelYouWin to the center of the screen
		var panel_you_win_width = panel_you_win.size.x / 2
		var panel_you_win_height = panel_you_win.size.y / 2
		panel_you_win.position = Vector2((screen_width / 2) - panel_you_win_width, (screen_height / 2) - panel_you_win_height)
		
		activated = false # pause the game
		time_scale = 1
		Engine.time_scale = 1

# spawn a ball
func spawn_ball(unit_scene) -> void:
	if unit_scene != null:
		var ball = unit_scene.instantiate()
		add_child(ball)
		ball.position = Vector2(1040.0, 330.0)

# spawn a group of squares based on delays and amount
func spawn_square(square_scene, start_delay = 0.0, delay = 0.0, max_spawn = 1) -> void:
	await get_tree().create_timer(start_delay).timeout
	
	for i in range(max_spawn):
		if activated:
			var square = square_scene.instantiate()
			add_child(square)
			square.position = Vector2(125.0, 330.0)
			
			await get_tree().create_timer(delay).timeout # delay
		
var coins := 0
func add_coins(): # updates coins value by a small amount
	while true:
		if not activated:
			break
			
		await get_tree().create_timer(0.05).timeout
		coins += 2
		
func display_price(): # displays the balls' price
	for i in range(len(balls)):
		if balls[i] != null:
			price_displays[i].text = "$" + str(balls[i].instantiate().price)

# button GUIs to spawn the balls
func _on_spawn_1_pressed():
	if activated:
		spawn_ball(balls[0])
func _on_spawn_2_pressed():
	if activated:
		spawn_ball(balls[1])
func _on_spawn_3_pressed():
	if activated:
		spawn_ball(balls[2])
func _on_spawn_4_pressed():
	if activated:
		spawn_ball(balls[3])
func _on_spawn_5_pressed():
	if activated:
		spawn_ball(balls[3])
func _on_spawn_6_pressed():
	if activated:
		spawn_ball(balls[3])

# button GUI to retry/reload the level
func _on_you_lose_restart_pressed():
	restart_level()
# button GUI to go to the next level
func _on_you_win_next_level_pressed():
	pass

# button GUI to go back to start_menu
func _on_you_win_menu_pressed():
	go_to_start_menu()
# button GUI to go back to start_menu
func _on_you_lose_menu_pressed():
	go_to_start_menu()
	
func _on_restart_pressed():
	if activated:
		restart_level()
func _on_home_pressed():
	if activated:
		go_to_start_menu()

func go_to_start_menu():
	get_tree().change_scene_to_file("res://scenes/_menus/start_menu.tscn")
func restart_level():
	get_tree().reload_current_scene()

var time_scale = 1
func _on_speedup_pressed():
	if activated:
		time_scale += 1
		Engine.time_scale = time_scale
func _on_speeddown_pressed():
	if activated and time_scale != 0:
		time_scale -= 1
		Engine.time_scale = time_scale
