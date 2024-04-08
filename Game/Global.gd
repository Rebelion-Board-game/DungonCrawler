extends Node

const GRID_SIZE = 1

@onready var player = get_tree().get_root().get_node("World/Player")

@onready var player_pos = [Vector3.ZERO,Vector3.ZERO]
