class_name Player
extends CharacterBody2D

@onready var footstep = $footstep

# This is the root world scene we can use to switch menus
var _world:Node2D = World
const SPEED := 700.0
@onready var cam := $Camera2Ds
@onready var head: AnimatedSprite2D = $Head
@onready var body_sprite: AnimatedSprite2D = $BodySprite
@onready var health_bar = get_node("../CanvasLayer/HealthBar") 
@onready var damage_sound = $damage_taken_sound
@onready var death_sound = $death_sound
@onready var map_controller: MapController = $"../Maps"

# dash
const DASH_SPEED_MULT := 20.0
const DASH_TIME := 0.2
const DASH_COOLDOWN := 0.3
const DASH_ACCEL := 15000.0
const DASH_SLOWDOWN := 2000.0
const SPAWN_START := Vector2(-4500,768)

var dash_time := 0.0
var dash_cooldown := 0.0
var dash_direction := Vector2.ZERO
var current_speed := SPEED
var mouse_position : Vector2
var player_position : Vector2
var last_horizontal_direction := 1  # 1 for right, -1 for left (default to right)

var max_health := 100
var health := 100
var _dead : bool = false

@onready
var gun_manager : GunManager = $Body/Gun

func _ready() -> void:
	print("PlayerAnimations exists? ", has_node("PlayerAnimations"))
	print(name)
	health_bar.max_value = max_health
	health_bar.value = health
	global_position = SPAWN_START
	add_to_group("player")
	

func play_synced_animation(anim_name: String) -> void:
	head.play(anim_name)
	body_sprite.play(anim_name)
	
func _process(_delta: float) -> void:
	#look_at(get_global_mouse_position())
	mouse_position = get_global_mouse_position()
	player_position = global_position
	
	# if player taking damage, play damage sound
	if health_bar.value > health:
		damage_sound.play()
		
	health_bar.update_health(health)

	if health <= 0.0:
		_on_death()
	

func _physics_process(_delta: float) -> void:
	if _dead:
		return
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
	
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = true
		_world.pause_menu()
		return
		
	# Animation Handling
	var facing_left = mouse_position.x < player_position.x
	if move_direction == Vector2.ZERO:
		# if player isnt moving, play idle animation
		if facing_left:
			play_synced_animation("tiny_idle_left")
		else:
			play_synced_animation("tiny_idle_right")
			
			
	else:
		# old code, remove later
		'''
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
		'''
		if facing_left:
			play_synced_animation("tiny_walk_left")
			if not footstep.playing:
				footstep.play()
		else:
			play_synced_animation("tiny_walk_right")
			if not footstep.playing:
				footstep.play()
		
		
	move_and_slide()

func _on_death():
	_dead = true
	if not death_sound.playing:
		death_sound.play()

	await death_sound.finished
	
	_world.death_menu()
