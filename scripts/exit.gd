extends Node2D
var room
var world
var roomIsCleared = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# Loading Next Room
func _on_area_2d_body_entered(body):
	if body.is_in_group("player") and roomIsCleared == true:
		var room = get_parent()
		var world = room.get_parent()
		roomIsCleared = false
		world.loadnextroom()
			
func set_roomIsCleared(status):
	roomIsCleared = status


func _on_entrance_room_cleared():
	roomIsCleared = true
