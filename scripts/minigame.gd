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
func show_random_map(maps):
	var selected_map=randi_range(0,9)
	hide_maps(maps)
	maps[selected_map].visible=true
func _ready():
	show_random_map(tilemaps)
