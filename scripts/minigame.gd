extends Node
@onready var tilemaps= [
	$TileMap5,
	$TileMap,
	$TileMap2,
	$TileMap3,
	$TileMap4,
	$TileMap6,
	$TileMap7,
	$TileMap8,
	$TileMap9,
	$TileMap10
]
func hide_maps(maps):
	for map in maps:
		map.visible=false
func _ready():
	hide_maps(tilemaps)
