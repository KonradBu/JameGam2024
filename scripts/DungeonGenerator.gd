extends Node

var room = preload("res://scenes/Dungeon.tscn")

var minRooms = 6
var maxRooms = 8

var generationChance = 20

func generate(roomSeed):
	seed(roomSeed)
	var dungeon = {}
	var size = floor(randf_range(minRooms, maxRooms))
	
	dungeon[Vector2(0, 0)] = room.instantiate()
	size -= 1
	
	
	#generates a dungeon layout
	while(size > 0):
		for i in dungeon.keys():
			if (randi_range(0, 100) < generationChance) and size > 0:
				var direction = randf_range(0, 4)
				
				if direction < 1:
					var newRoomPosition = i + Vector2(1, 0)
					if !dungeon.has(newRoomPosition):
						dungeon[newRoomPosition] = room.instantiate()
						size -= 1
					if dungeon.get(i).connectedRooms.get(Vector2(1, 0)) == null:	
						connect_rooms(dungeon.get(i), dungeon.get(newRoomPosition), Vector2(1,0))
				elif direction < 2:
					var newRoomPosition = i + Vector2(-1, 0)
					if !dungeon.has(newRoomPosition):
						dungeon[newRoomPosition] = room.instantiate()
						size -= 1
					if dungeon.get(i).connectedRooms.get(Vector2(-1, 0)) == null:	
						connect_rooms(dungeon.get(i), dungeon.get(newRoomPosition), Vector2(-1,0))
				elif direction < 3:
					var newRoomPosition = i + Vector2(0, 1)
					if !dungeon.has(newRoomPosition):
						dungeon[newRoomPosition] = room.instantiate()
						size -= 1
					if dungeon.get(i).connectedRooms.get(Vector2(0, 1)) == null:	
						connect_rooms(dungeon.get(i), dungeon.get(newRoomPosition), Vector2(0,1))
				elif direction < 4:
					var newRoomPosition = i + Vector2(0, -1)
					if !dungeon.has(newRoomPosition):
						dungeon[newRoomPosition] = room.instantiate()
						size -= 1
					if dungeon.get(i).connectedRooms.get(Vector2(0, -1)) == null:	
						connect_rooms(dungeon.get(i), dungeon.get(newRoomPosition), Vector2(0,-1))
	while isInteresting(dungeon):
		for i in dungeon.keys():
			dungeon.get(i).queue_free()
		dungeon = generate(roomSeed*randf_range(-1, 1)+ randf_range(-100, 100))
	return dungeon

func connect_rooms(room1, room2, arraydirection):
	room1.connectedRooms[arraydirection] = room2
	room2.connectedRooms[-arraydirection] = room1
	room1.numOfConnnections += 1
	room2.numOfConnnections += 1

func  isInteresting(dungeon):
	var room_with_three = 0
	for i in dungeon.keys():
		if dungeon.get(i).numOfConnnections >= 3:
			room_with_three+= 1
	return room_with_three >= 2
