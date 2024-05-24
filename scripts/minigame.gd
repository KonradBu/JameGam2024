extends Node2D
const N = 1
const E = 2
const S = 4
const W = 8
@onready var Map = $TileMap
var cell_walls = {Vector2(1, 0): E, Vector2(-1, 0): W,
				  Vector2(0, 1): S, Vector2(0, -1): N}
var tile_size = 64
var width = 25
var height = 15

