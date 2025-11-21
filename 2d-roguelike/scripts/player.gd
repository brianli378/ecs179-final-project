class_name Player
extends CharacterBody2D

# This is the root world scene we can use to switch menus
var _world:Node2D = World

const SPEED := 700.0

# dash
const DASH_SPEED_MULT := 20.0
const DASH_TIME := 0.2
const DASH_COOLDOWN := 0.3
const DASH_ACCEL := 15000.0
const DASH_SLOWDOWN := 2000.0

var dash_time := 0.0
var dash_cooldown := 0.0
var dash_direction := Vector2.ZERO
var current_speed := SPEED


func _process(_delta: float) -> void:
	look_at(get_global_mouse_position())
	

func _physics_process(_delta: float) -> void:
	var move_direction := Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()

	if Input.is_action_just_pressed("dash") and dash_cooldown <= 0.0 and move_direction != Vector2.ZERO:
		dash_direction = move_direction
		dash_time = DASH_TIME
		dash_cooldown = DASH_COOLDOWN
		current_speed = SPEED * DASH_SPEED_MULT

	if dash_time > 0.0:
		dash_time = dash_time - _delta
		var falloff := (SPEED * (DASH_SPEED_MULT - 1.0)) / DASH_TIME
		current_speed = move_toward(current_speed, SPEED, falloff * _delta)
	else:
		current_speed = move_toward(current_speed, SPEED, DASH_SLOWDOWN * _delta)

	var direction: Vector2
	if dash_time > 0.0 and dash_direction != Vector2.ZERO:
		direction = dash_direction
	else:
		direction = move_direction

	var target_velocity: Vector2
	if direction != Vector2.ZERO:
		target_velocity = direction * current_speed
	else:
		target_velocity = Vector2.ZERO

	velocity = velocity.move_toward(target_velocity, DASH_ACCEL * _delta)

	if dash_cooldown > 0.0:
		dash_cooldown = max(0.0, dash_cooldown - _delta)

	if Input.is_action_just_pressed("ui_accept"):
		_world.death_menu()
	
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = true
		_world.pause_menu()
		
	move_and_slide()
