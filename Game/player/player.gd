extends CharacterBody3D

@export var direction := Vector3.FORWARD
@export var rotation_time := 0.2
@export var move_time := 0.4 
@export var bob_height := 0.1

@onready var forward: = $Ray_front
@onready var camera = $Camera3D

var is_rotating := false
var is_moving := false

const SPEED = 100

func _physics_process(_delta) -> void:
	if is_moving or is_rotating:
		return
	
	if Input.is_action_pressed("ui_up"):
		move()
	if Input.is_action_pressed("ui_left"):
		rotate_and_set_direction(90)
		await get_tree().create_timer(0.3).timeout
	if Input.is_action_pressed("ui_right"):
		rotate_and_set_direction(-90)
		await get_tree().create_timer(0.3).timeout

func collision_check(direction) -> bool:
	if direction != null:
		return direction.is_colliding()
	else:
		return false

func move() -> void:
	if forward.is_colliding() or is_moving:
		return
	
	is_moving = true
	
	var target_position = global_position + direction
	
	var move_tween = get_tree().create_tween()
	move_tween.tween_property(self, "global_position", target_position, move_time)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_IN_OUT)
		
	var bob_tween = get_tree().create_tween()
	var start_cam_y = camera.position.y
	
	bob_tween.tween_property(camera, "position:y", start_cam_y + bob_height, move_time / 2.0)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_OUT)
	bob_tween.tween_property(camera, "position:y", start_cam_y, move_time / 2.0)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_IN)
		
	await move_tween.finished
	is_moving = false

func _input(event) -> void:
	if is_rotating:
		return
	if event.is_action_pressed("ui_down"):
		rotate_and_set_direction(180)


func rotate_and_set_direction(angle_delta: float) -> void:
	is_rotating = true
	var new_y = rotation_degrees.y + angle_delta
	var tween = get_tree().create_tween()
	tween.tween_property(self, "rotation_degrees:y", new_y, rotation_time).set_ease(Tween.EASE_OUT)
	await tween.finished
	direction = -global_transform.basis.z.normalized()
	is_rotating = false
