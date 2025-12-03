## source: https://casraf.dev/2024/09/pathfinding-guide-for-2d-top-view-tiles-in-godot-4-3/

extends TileMapLayer

var _obstacle_cells: Dictionary = {}

func _ready() -> void:
	_populate_obstacle_cells()

func _populate_obstacle_cells() -> void:
	for cell in get_used_cells():
		var tile_data = get_cell_tile_data(cell)
		if tile_data.get_collision_polygons_count(0) > 0:
			_obstacle_cells[cell] = true  # store cell as key

func _is_used_by_obstacle(coords: Vector2i) -> bool:
	return _obstacle_cells.has(coords)  # O(1) lookup

func _use_tile_data_runtime_update(coords: Vector2i) -> bool:
	return not _is_used_by_obstacle(coords)

func _tile_data_runtime_update(coords: Vector2i, tile_data: TileData) -> void:
	if _is_used_by_obstacle(coords):
		tile_data.set_navigation_polygon(0, null)
