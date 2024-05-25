extends Control

var hasWatchedCutscene = false
@onready var credits = $Credits

func _on_play_pressed():
	var world = preload("res://scenes/world.tscn")
	var cutscene = preload("res://scenes/cutscene.tscn")
	
	if hasWatchedCutscene == false:
		get_tree().change_scene_to_packed(cutscene)
		hasWatchedCutscene = true
	elif hasWatchedCutscene == true:
		get_tree().change_scene_to_packed(world)


func _on_options_pressed():
	pass # Replace with function body.

func _on_quit_pressed():
	get_tree().quit()
	
func _on_credits_pressed():
	credits.visible = true

func _on_exit_credits_pressed():
	credits.visible = false
