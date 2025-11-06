extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_level_1_pressed():
	get_tree().change_scene_to_file("res://scenes/_levels/level1.tscn")

func _on_level_2_pressed():
	pass
	
func _on_level_3_pressed():
	pass

func _on_close_pressed():
	get_tree().change_scene_to_file("res://scenes/_menus/start_menu.tscn")

