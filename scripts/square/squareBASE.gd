extends CharacterBody2D
class_name Square

var speed = 70.0
var health = 100.0
var price = 100.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.x = speed
		velocity.y = 0
		
	move_and_slide()
	
func get_health():
	return health
	
func take_damage(unit_health):
	health -= unit_health
	
	if health <= 0:
		explode()
		queue_free()

func explode():
	var explosion = preload("res://scenes/animations/explosionSquare.tscn").instantiate()
	
	explosion.global_position = global_position
	explosion.scale = explosion.scale * (scale / 0.7)
	
	get_parent().add_child(explosion)
	queue_free()
