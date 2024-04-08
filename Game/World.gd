extends Node3D

const Cell = preload("res://Game/cell/cell.tscn")

@export var Map: PackedScene

var cells = []

func _ready():
	var map = Map.instantiate()
	var tile_map = map.get_tilemap()
	var used_tiles = tile_map.get_used_cells(0)
	map.free()
	for tile in used_tiles:
		var cell = Cell.instantiate()
		add_child(cell)
		cells.append(cell)
		cell.global_transform.origin = Vector3(tile.x*Global.GRID_SIZE, 0, tile.y*Global.GRID_SIZE)
	for cell in cells:
		cell.update_faces(used_tiles)
	
	# Generate enemy
	generate(1,"res://Game/enemy/enemy.tscn")

func generate(layer: int, scene: String):
	var Scene = load(scene)
	var models = []
	# Get info from tile map
	var map = Map.instantiate()
	var tile_map = map.get_tilemap()
	
	# Check if layer exist in tile map
	var layers = tile_map.get_layers_count()
	if layer+1 > layers:
		print("Layer", layer, "does not exist in the tilemap.")
		return
	var used_tiles = tile_map.get_used_cells(layer)
	map.queue_free()
	
	# Create 3D cells with info from tile map
	for tile in used_tiles:
		var model = Scene.instantiate()
		add_child(model)
		models.append(model)
		model.global_transform.origin = Vector3(tile.x * Global.GRID_SIZE, 0, tile.y * Global.GRID_SIZE)
		
