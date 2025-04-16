extends Node3D

const Cell = preload("res://Game/cell/cell.tscn")

@export var Map: PackedScene

var cells = []

func _ready():
	var map = Map.instantiate()
	var tile_map = map.get_tilemap()
	var used_tiles = tile_map.get_used_cells()
	map.free()
	for tile in used_tiles:
		var cell = Cell.instantiate()
		add_child(cell)
		cells.append(cell)
		cell.global_transform.origin = Vector3(tile.x*Global.GRID_SIZE, 0, tile.y*Global.GRID_SIZE)
	for cell in cells:
		cell.update_faces(used_tiles)
