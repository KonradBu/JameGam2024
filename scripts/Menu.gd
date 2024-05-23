extends Control



func _on_play_pressed():
	var world = preload("res://scenes/world.tscn")
	get_tree().change_scene_to_packed(world)


func _on_options_pressed():
	pass # Replace with function body.


func _on_exit_pressed():
	get_tree().quit()
