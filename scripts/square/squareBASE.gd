extends CharacterBody2D
class_name Square

var speed = 70.0
var health = 100.0
var price = 100.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var base_health = 500

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.x = speed
		velocity.y = 0
		
	if is_on_wall():
		var level  = get_tree().get_first_node_in_group("level")
		
		if level:
			level.base_health -= health
			queue_free()
		
	move_and_slide()
	
func get_health():
	return health
	
func take_damage(unit_health):
	health -= unit_health
	
	if health <= 0:
		add_coins()
		
		explode()
		queue_free()

func explode():
	var explosion = preload("res://scenes/_animations/explosionSquare.tscn").instantiate()
	
	explosion.global_position = global_position
	explosion.scale = explosion.scale * (scale / 0.7)
	
	get_parent().add_child(explosion)
	queue_free()

var coins_drop = 100
func add_coins():
	var level = get_tree().get_first_node_in_group("level")
	
	if level:
		level.coins += coins_drop
