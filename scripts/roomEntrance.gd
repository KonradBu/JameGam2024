extends Node2D
var roomIsCleared = false
var top_left = Vector2(0,0)
var bottom_right = Vector2(1920,1080)
var world
signal roomCleared

# Called when the node enters the scene tree for the first time.
func _ready():
	world = get_parent()
	world.set_roomIsCleared(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
		pass
		
		
func minus_enemy_count():
	world.minus_enemycount()

func set_roomIsCleared(status):
	roomIsCleared = status
	if (roomIsCleared == true):
		emit_signal("roomCleared")
