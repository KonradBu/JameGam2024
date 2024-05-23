extends Node2D
@onready var tilemap = $TileMap
const initial_width = 37
const initial_height = 21
var map_width = initial_width
var map_height = initial_height
var map_offset = 4
const Fail_tile_id = 0
const Safe_tile_id = 1
const Win_tile_id = 3
const tile_layer=0
func _ready():
	generate_failure()
func generate_failure():
	for x in range(map_width):
		for y in range(map_height):
			if x == 0 or x == map_width - 1 or y == 0 or y == map_height - 1:
				print(x)
				print(y)
				print("next")
				tilemap.set_cell(tile_layer,Vector2i(x, y + map_offset),Fail_tile_id,Vector2i(0, 0), 0)
