class_name Player
extends CharacterBody2D

# This is the root world scene we can use to switch menus
var _world:Node2D = World

const SPEED := 700.0
@onready var cam := $Camera2D
@onready var anim: AnimatedSprite2D = $PlayerAnimations

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
var mouse_position : Vector2
var player_position : Vector2
var last_horizontal_direction := 1  # 1 for right, -1 for left (default to right)

func _ready() -> void:
	print("PlayerAnimations exists? ", has_node("PlayerAnimations"))
	print(name)

func _process(_delta: float) -> void:
	#look_at(get_global_mouse_position())
	mouse_position = get_global_mouse_position()
	player_position = global_position
	

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
		
	# Animation Handling
	if move_direction == Vector2.ZERO:
		# if player isnt moving, play idle animation
		if mouse_position.x - player_position.x < 0:
			anim.play("tiny_idle_left")
		else:
			anim.play("tiny_idle_right")
			
	else:
		# if player is moving horizontally
		if abs(move_direction.x) > abs(move_direction.y):
			last_horizontal_direction = sign(move_direction.x) 
			anim.play("tiny_walk_right" if move_direction.x > 0 else "tiny_walk_left")
		# if player is moving more vertically
		elif abs(move_direction.x) < abs(move_direction.y):
			#anim.play("tiny_walk_right" if last_horizontal_direction > 0 else "tiny_walk_left")
			if mouse_position.x - player_position.x < 0:
				anim.play("tiny_walk_left")
			else:
				anim.play("tiny_walk_right")
		
	move_and_slide()
