extends Node2D
@onready var tilemap = $TileMap
const initial_width = 37
const initial_height = 21
var map_width = initial_width
var map_height = initial_height
var map_offset = 4 
const Safe_areas =1
const Bad_areas = 0
const Collection_areas = 3
const Tile_layer = 0
func _ready():
		generate_fails()

func generate_fails():
	for x in range(map_width):
		for y in range(map_height):
			if x == 0 or x == map_width - 1 or y == 0 or y == map_height - 1:
				tilemap.set_cell(Tile_layer, Vector2i(x, y + map_offset), Bad_areas, Vector2i(0, 0), 0)
