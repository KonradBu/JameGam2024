extends TileMap
var patient_health := 100.0
var game_progress := 0.0
func _physics_process(_delta):
	var mouse_pos_global = get_viewport().get_mouse_position()
	var mouse_pos_local = to_local(mouse_pos_global)
	var tile_pos = local_to_map(mouse_pos_local)
	var tile_id = get_cell_source_id(0, tile_pos)
	if tile_id == 0:
		patient_health-=1
	if tile_id== 3:
		var tile : Vector2 = local_to_map(get_global_mouse_position())
		set_cell(0,tile,2)
		game_progress+=0.1
	if patient_health<=0:
		print("HE'S DEAD JIM!")
	if game_progress>=1:
		print("You win!")
