extends Control

func _on_start_pressed():
	get_tree().change_scene_to_file("res://scenes/_levels/level1.tscn")

func _on_levels_pressed():
	get_tree().change_scene_to_file("res://scenes/_menus/level_menu.tscn")

func _on_settings_pressed():
	pass # Replace with function body.
