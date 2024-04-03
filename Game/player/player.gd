extends CharacterBody3D

#@onready var timerprocessor: = $Timer
#@onready var animation: = $AnimationPlayer
@onready var forward: = $Ray_front
@onready var camera = $Camera3D	

var direction = Vector3.FORWARD

const SPEED = 100

func collision_check(direction):
	if direction != null:
		return direction.is_colliding()
	else:
		return false

func get_direction():
	return direction.get_collider().global_transform.origin - global_transform.origin
	
func move():
	if !forward.is_colliding():
		global_transform.origin.x += direction.x
		global_transform.origin.z += direction.z

func _input(event):
	if event.is_action_pressed("ui_up"):
		move()
	if event.is_action_pressed("ui_left"):
		rotate_y(deg_to_rad(90))
		direction = -camera.global_transform.basis.z.normalized()
	if event.is_action_pressed("ui_right"):
		rotate_y(deg_to_rad(-90))
		direction = -camera.global_transform.basis.z.normalized()
	if event.is_action_pressed("ui_down"):
		rotate_y(deg_to_rad(180))
		direction = -camera.global_transform.basis.z.normalized()
