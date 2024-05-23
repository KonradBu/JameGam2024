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
