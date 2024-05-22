extends Node2D
var enemycount = 0
var top_left = Vector2(0,0)
var bottom_right = Vector2(1920,1080)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if enemycount < 1:
		pass

func set_enemy_count(i):
	enemycount = i
