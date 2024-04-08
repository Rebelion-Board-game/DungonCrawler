extends CharacterBody3D

#@onready var timerprocessor: = $Timer
#@onready var animation: = $AnimationPlayer
@onready var forward: = $Ray_front
@onready var back: = $Ray_back
@onready var right: = $Ray_right
@onready var left: = $Ray_left
@onready var camera = $Camera3D	

var direction = Vector3.FORWARD

const SPEED = 100

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

func _process(_delta):
	Global.player_pos[0] = transform.basis.z
	Global.player_pos[1] = transform.basis.x
