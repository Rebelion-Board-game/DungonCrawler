extends Node3D

func _process(_delta):
	# Turn into player direction
	transform.basis.z = Global.player_pos[0]
	transform.basis.x = Global.player_pos[1]


