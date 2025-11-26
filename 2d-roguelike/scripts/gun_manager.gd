class_name GunManager
extends Node2D

@onready var projectile_spawn: Node2D = $ProjectileSpawn
@onready var gun_sprite: Sprite2D = $Sprite2D
@onready var camera: Camera2D = get_parent().get_parent().get_node("Camera2D") as Camera2D
@onready var player: CharacterBody2D = get_parent().get_parent()

@export var offset_right: Vector2 = Vector2(-90, 20)
@export var offset_left: Vector2 = Vector2(90, 20)

var _projectile_scene = preload("res://scenes/projectile.tscn")
var _time_since_last_shot: float = 0.0
var facing_right = false
var default_state = true

var guns: Array[Gun] = []
var curr_gun_index: int = 0
var curr_gun: Gun = null

var gun_textures: Array[Texture2D] = [
	preload("res://assets/pistol_sprite.png"),    # Index 0 - Pistol
	#TODO: add machine gun sprite
	preload("res://assets/pistol_sprite.png"), # Index 1 - MachineGun
	preload("res://assets/shotgun_sprite.png")      # TODO: placeholder sprite
]

# Gun-specific offsets when facing right
var gun_offsets_right: Array[Vector2] = [
	Vector2(-90, 20),   # Index 0 - Pistol
	Vector2(-85, 25),   # Index 1 - MachineGun
	Vector2(-50, 18)    # Index 2 - Sniper
]

# Gun-specific offsets when facing left
var gun_offsets_left: Array[Vector2] = [
	Vector2(90, 20),    # Index 0 - Pistol
	Vector2(85, 25),    # Index 1 - MachineGun
	Vector2(50, 18)     # Index 2 - Sniper
]

func _ready() -> void:
	guns = [
		Pistol.new(),
		MachineGun.new(),
		Sniper.new()
	]
	
	curr_gun = guns[curr_gun_index]
	_update_gun_texture()  # Set initial texture

func _process(_delta: float) -> void:
	_time_since_last_shot += _delta
	
	var mouse_pos = get_global_mouse_position()
	var player_position = global_position
	var mouse_direction = mouse_pos.x - player_position.x
	
	if player.velocity.x > 0 or default_state:
		# if player is moving right
		scale.y = 1
		position = gun_offsets_left[curr_gun_index]
		facing_right = true
		default_state = false
		
	elif player.velocity.x < 0 or mouse_direction < 0:
		# if player is moving left
		scale.y = -1
		position = gun_offsets_right[curr_gun_index]
		facing_right = false
		default_state = false
		
	elif mouse_direction > 100 and player.velocity.x == 0:
		# if player is looking left
		scale.y = 1
		position = gun_offsets_left[curr_gun_index]
		facing_right = true
		default_state = false
		
	elif mouse_direction < -100 and player.velocity.x == 0:
		# if player is looking rihgt
		scale.y = -1
		position = gun_offsets_right[curr_gun_index]
		facing_right = false
		default_state = false
		
	look_at(mouse_pos)
		
	if facing_right:
		# when facing right, limit rotation
		rotation = clamp(rotation, -1.5, 1.5)
	else:
		# when facing left, limit rotation
		var abs_rotation = abs(rotation)
		abs_rotation = clamp(abs_rotation, 1.5, 5)
		rotation = sign(rotation) * abs_rotation
		
	if Input.is_action_just_pressed("switch_gun"):
		curr_gun_index = (curr_gun_index + 1) % guns.size()
		curr_gun = guns[curr_gun_index]
		_update_gun_texture()  # Update texture when switching guns
			
		
	var should_shoot := false
	if curr_gun.firing_mode == Gun.FiringMode.SEMI_AUTO:
		should_shoot = Input.is_action_just_pressed("shoot")
	elif curr_gun.firing_mode == Gun.FiringMode.AUTO:
		should_shoot = Input.is_action_pressed("shoot")
	
	if should_shoot and _time_since_last_shot >= curr_gun.shot_delay:
		_shoot()
		_time_since_last_shot = 0.0


func _shoot() -> void:
	var projectile: Projectile = _projectile_scene.instantiate()
	projectile.global_position = projectile_spawn.global_position
	
	var direction: Vector2 = projectile_spawn.global_transform.x.normalized()
	projectile.linear_velocity = direction * curr_gun.projectile_speed
	
	camera.add_shake(0.17)
	
	for child in projectile.get_children():
		child.scale = curr_gun.projectile_scale
	
	self.get_tree().current_scene.add_child(projectile)

func _update_gun_texture() -> void:
	if gun_sprite and curr_gun_index >= 0 and curr_gun_index < gun_textures.size():
		gun_sprite.texture = gun_textures[curr_gun_index]
	else:
		push_error("Invalid gun index or gun_sprite not found: " + str(curr_gun_index))
