extends Area2D
var clearedRoomCounter = 0
var roomsToBossFight = 15
var numberOfRooms = 1
var roomIsCleared = false
var rooms = ["res://scenes/roomFloor.tscn"]
var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_body_entered(body):
	if body.is_in_group("player") and roomIsCleared == true:
		var usedRooms = []
		var random = rng.randi_range(0, numberOfRooms -1)
		while random in usedRooms:
			random = rng.randi_range(0,numberOfRooms -1)
		usedRooms.push_back(random)
		var newroom = rooms[random]
		get_tree().change_scene_to_file(newroom)
		var lowerRange = clearedRoomCounter
		var upperRange = clearedRoomCounter + 4
		if (clearedRoomCounter < 3):
			lowerRange = 2
			upperRange = clearedRoomCounter +2
		var randomEnemies = rng.randi_range(lowerRange, upperRange)
		newroom.enemycount = randomEnemies
		var enemyScene = preload("res://scenes/enemy.tscn")
		for i in range(randomEnemies):
			newroom.add_child(enemyScene)
