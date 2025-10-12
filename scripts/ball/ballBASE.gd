extends CharacterBody2D
class_name Ball

var speed = 70.0
var health = 100.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0
		velocity.x = -speed
		
	if is_on_wall():
		var level = get_tree().get_first_node_in_group("level")
		
		if level:
			level.enemy_base_health -= health
			queue_free()
			
	move_and_slide()

func _on_area_2d_body_entered(body):
	if body.is_in_group("square"):
		var enemy_health = body.get_health()
		var unit_health = health
		
		take_damage(enemy_health)
		body.take_damage(unit_health)
	
func get_health():
	return health

func take_damage(enemy_health):
	health -= enemy_health
	
	if health <= 0:
		explode()
		queue_free()

func explode():
	var explosion = preload("res://scenes/_animations/explosionBall.tscn").instantiate()
	
	explosion.global_position = global_position
	explosion.scale = explosion.scale * (scale / 0.7)
	
	get_parent().add_child(explosion)
	queue_free()

var price = 100

func deduct_coins():
	var level = get_tree().get_first_node_in_group("level")
	if level and level.coins >= price:
		level.coins -= price
	else:
		queue_free()
