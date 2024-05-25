extends Node2D
var top_left = Vector2(0,0)
var bottom_right = Vector2(1920,1080)
var world
var roomIsCleared
# Called when the node enters the scene tree for the first time.


func _ready():
	world = get_parent()
	world.spawn_enemies()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func minus_enemy_count():
	world.minus_enemycount()
	
func set_roomIsCleared(status):
	roomIsCleared = status
	$exit.set_roomIsCleared(status)
