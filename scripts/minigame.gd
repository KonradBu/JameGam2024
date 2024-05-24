extends Node2D

@export var width := 5 
@export var height := 5 

func generate(tile_map: TileMap):
	var visited : Array
	var search_stack : Array
	var connections = {}
	
	var all_points = []
	for i in range(width * height):
		var x = i % width
		var y = floor(i / height)
		var point = Vector2(x, y)
		
		all_points.push_back(point)
		connections[point] = 0b0000
		
	var start = all_points[randi() % all_points.size()]
	search_stack = [start]
	visited = [start]
	
	while search_stack.size() > 0:
		var current = search_stack[0]
		var valid_neighbors = _get_valid_neighbors(current)
		var unvisited_neighbors = []
		for neighbor in valid_neighbors:
			if not visited.has(neighbor):
				unvisited_neighbors.push_front(neighbor)
		if unvisited_neighbors.size() > 0:
			var next = unvisited_neighbors[randi() % unvisited_neighbors.size()]
			var current_connections = connections[current]
			connections[current] = _set_connection(current_connections, next - current)
			var next_connections = connections[next]
			connections[next] = _set_connection(next_connections, current - next)
			visited.push_front(next)
			search_stack.push_front(next)
		else:
			search_stack.pop_front()
	
	for point in all_points:
		var conns = connections[point]
		tile_map.set_cellv(point, conns)
		

func _get_valid_neighbors(tile: Vector2) -> Array:
	var candidates = [
		tile + Vector2.UP,
		tile + Vector2.DOWN,
		tile + Vector2.RIGHT,
		tile + Vector2.LEFT
	]
	var neighbors = []
	
	for candidate in candidates:
		if (candidate.x < 0
			or candidate.x >= width
			or candidate.y < 0
			or candidate.y >= height):
			continue
		
		neighbors.push_back(candidate)
	return neighbors
	
func _set_connection(connection_bits, target):
	match target:
		Vector2.UP:
			return connection_bits | 0b1000
		Vector2.DOWN:
			return connection_bits | 0b0100
		Vector2.RIGHT:
			return connection_bits | 0b0010
		Vector2.LEFT:
			return connection_bits | 0b0001

func set_width(value):
	width = int(max(5, value))
	
func set_height(value):
	height = int(max(5, value))
