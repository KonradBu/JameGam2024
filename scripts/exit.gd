extends Node2D


var clearedRoomCounter = 0
var roomsToBossFight = 15
var numberOfRooms = 1
var roomIsCleared = false
var rooms = ["res://scenes/roomFloor.tscn"]
var rng = RandomNumberGenerator.new()
var usedRooms = []
# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


			
func set_roomIsCleared (status):
	roomIsCleared = status

# Loading Next Room
func _on_area_2d_body_entered(body):
		if body.is_in_group("player") and roomIsCleared == true:
			var random = rng.randi_range(0, numberOfRooms -1)
			while random in usedRooms:
				random = rng.randi_range(0,numberOfRooms -1)
			usedRooms.push_back(random)
			var newroom = load(rooms[random])
			var newroominstance = newroom.instantiate()
			get_tree().change_scene_to_packed(newroom)
			var lowerRange = clearedRoomCounter
			var upperRange = clearedRoomCounter + 4
			if (clearedRoomCounter < 3):
				lowerRange = 2
				upperRange = clearedRoomCounter +2
			var randomEnemies = rng.randi_range(lowerRange, upperRange)
			newroominstance.set_enemy_count(randomEnemies)
			var enemyScene = preload("res://scenes/enemy.tscn")
			for i in range(randomEnemies):
				var enemyinstance = enemyScene.instantiate()
				newroominstance.add_child(enemyinstance)
