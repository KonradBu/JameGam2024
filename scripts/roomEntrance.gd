extends Node2D
var roomIsCleared = false
var top_left = Vector2(0,0)
var bottom_right = Vector2(1100,600)
var world
signal roomCleared
var playerspawnposition = Vector2(400,330)
var companionspawnposition = Vector2(500,300)

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
