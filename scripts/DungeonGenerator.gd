extends Node

var room = preload("res://scenes/room.tscn")

var minRooms = 6
var maxRooms = 10

var generationChance = 20

func generate(roomSeed):
	seed(roomSeed)
	var dungeon = {}
	var size = floor(randi_range(minRooms, maxRooms))
	
	dungeon[Vector2(0, 0)] = room.instantiate()
	size -= 1
	
	while(size > 0):
		for i in dungeon.keys():
			if (randi_range(0, 100) < generationChance) and size > 0:
				var direction = randi_range(0, 4)
				
				if direction < 1:
					var newRoomPosition = i + Vector2(1, 0)
					if !dungeon.has(newRoomPosition):
						dungeon[newRoomPosition] = room.instantiate()
						size -= 1
					connect_rooms(dungeon.get(i), dungeon.get(newRoomPosition),[1,0])
				elif direction < 2:
					var newRoomPosition = i + Vector2(-1, 0)
					if !dungeon.has(newRoomPosition):
						dungeon[newRoomPosition] = room.instantiate()
						size -= 1
					connect_rooms(dungeon.get(i), dungeon.get(newRoomPosition),[-1,0])
				elif direction < 3:
					var newRoomPosition = i + Vector2(0, 1)
					if !dungeon.has(newRoomPosition):
						dungeon[newRoomPosition] = room.instantiate()
						size -= 1
					connect_rooms(dungeon.get(i), dungeon.get(newRoomPosition),[0, 1])
				elif direction < 4:
					var newRoomPosition = i + Vector2(0, -1)
					if !dungeon.has(newRoomPosition):
						dungeon[newRoomPosition] = room.instantiate()
						size -= 1
					connect_rooms(dungeon.get(i), dungeon.get(newRoomPosition),[0, -1])
	return dungeon

func connect_rooms(room1, room2, direction):
	room1.connectedRooms[direction] = room2
	room2.connectedRooms[-direction] = room1
	room1.numOfConnections += 1
	room2.numOfConnections += 1
