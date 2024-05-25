extends Node2D

var connectedRooms = {
	Vector2(1,0) : null,
	Vector2(-1,0) : null,
	Vector2(0,1) : null,
	Vector2(0,-1) : null
}

var numOfConnnections = 0

func get_room_directional(key):
	return connectedRooms[key]
