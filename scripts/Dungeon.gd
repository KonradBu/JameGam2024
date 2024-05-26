extends Node2D

var dungeon = {}
var node_sprite = preload("res://scenes/room_2.tscn")
var branch_sprite = preload("res://scenes/tutorial.tscn")

@onready var map_node = $MapNode

func _ready():
	dungeon = DungeonGenerator.generate(0)
	load_map()

func load_map():
		for i in range(0, map_node.get_child_count()):
			map_node.get_child(i).queue_free()
			
		for i in dungeon.keys():
			var temp = node_sprite.instantiate()
			map_node.add_child(temp)
			temp.position = i * 150
			temp.scale = Vector2(0.1, 0.1)
			var c_rooms = dungeon.get(i).connectedRooms
			if(c_rooms.get(Vector2(1, 0)) != null):
				temp = branch_sprite.instantiate()
				map_node.add_child(temp)
				temp.position = i * 10 + Vector2(300, 30)
				temp.scale = Vector2(0.1, 0.1)
			if(c_rooms.get(Vector2(0, 1)) != null):
				temp = branch_sprite.instantiate()
				map_node.add_child(temp)
				temp.rotation_degrees = 90
				temp.position = i * 10 + Vector2(-30, 300)
				temp.scale = Vector2(0.1, 0.1)

func _on_button_pressed():
	randomize()
	dungeon = DungeonGenerator.generate(randf_range(-1000, 1000))
	load_map()
