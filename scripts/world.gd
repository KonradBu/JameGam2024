extends Node2D

var clearedRoomCounter = 0
var roomsToBossFight = 15
var numberOfRooms = 1
var roomIsCleared = false
var rooms = ["res://scenes/roomFloor.tscn"]
var usedRooms = []
var rng = RandomNumberGenerator.new()
var enemycount = 0
var currentroom

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	var newroom = load("res://scenes/roomEntrance.tscn")
	var newroominstance = newroom.instantiate()
	add_child(newroominstance)
	currentroom = newroominstance
	currentroom.set_roomIsCleared(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func loadnextroom():
	var random = rng.randi_range(0, numberOfRooms -1)
	while random in usedRooms:
		random = rng.randi_range(0,numberOfRooms -1)
	usedRooms.push_back(random)
	var newroom = load(rooms[random])
	var newroominstance = newroom.instantiate()
	loadroom(newroominstance)
	
func spawn_enemies():
	var lowerRange = clearedRoomCounter
	var upperRange = clearedRoomCounter + 4
	if (clearedRoomCounter < 3):
		lowerRange = 2
		upperRange = clearedRoomCounter +2
	var randomEnemies = rng.randi_range(lowerRange, upperRange)
	enemycount = randomEnemies
	var enemyScene = preload("res://scenes/enemy.tscn")
	for i in range(randomEnemies):
		var enemyinstance = enemyScene.instantiate()
		currentroom.call_deferred("add_child", enemyinstance)
		
func set_roomIsCleared (status):
	roomIsCleared = status
	
func minus_enemycount ():
	enemycount -= 1

func die():
	var entrance = preload("res://scenes/roomEntrance.tscn").instantiate()
	loadroom(entrance)
	
func loadroom(room):
	call_deferred("add_child", room)
	call_deferred("remove_child", currentroom)
	currentroom = room
	var playerscene = preload("res://scenes/Player.tscn")
	room.call_deferred("add_child", playerscene)
	playerscene.call_deferred("set_playerposition", room.playerspawnposition)
	var companionscene = preload("res://scenes/companion.tscn")
	room.call_deferred("add_child", companionscene)
	companionscene.call_deferred("set_companionposition", room.companionspawnposition)
