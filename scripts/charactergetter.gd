extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_position_body():
	return $CharacterBody2D.get_global_position()

func set_player_position(position):
	$CharacterBody2D.position = position