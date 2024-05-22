extends TileMap

func _physics_process(_delta):
	var mouse_pos_global = get_viewport().get_mouse_position()
	var mouse_pos_local = to_local(mouse_pos_global)
	var tile_pos = local_to_map(mouse_pos_local)
	var tile_id = get_cell_source_id(0, tile_pos)
	if tile_id == 0:
		print("kill him")
