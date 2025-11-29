class_name GunManager
extends Node2D

# Rotation pivot node was just added because godot is being mean about
# me changing the rotation pivot of a gun.
@onready var rotation_pivot: Node2D = $RotationPivot
@onready var projectile_spawn: Node2D = $RotationPivot/ProjectileSpawn
@onready var gun_sprite: Sprite2D = $RotationPivot/Sprite2D
@onready var camera: Camera2D = get_parent().get_parent().get_node("Camera2D") as Camera2D
@onready var player: CharacterBody2D = get_parent().get_parent()

@export var offset_right: Vector2 = Vector2(-90, 20)
@export var offset_left: Vector2 = Vector2(90, 20)

var _projectile_scene = preload("res://scenes/projectile.tscn")

# Load the projectile types
var projectile_library = {
	"normal": preload("res://specs/projectiles/normal_projectile.tres"),
	"laser":  preload("res://specs/projectiles/laser_projectile.tres"),
	"rocket": preload("res://specs/projectiles/rocket_projectile.tres")
}
#var normal_projectile_spec = preload("res://specs/projectiles/normal_projectile.tres")
#var laser_projectile_spec = preload("res://specs/projectiles/laser_projectile.tres")
#var rocket_projectile_spec = preload("res://specs/projectiles/rocket_projectile.tres")

var _time_since_last_shot: float = 0.0
var facing_right = false
var default_state = true

var guns: Dictionary = {} 
#var gun_keys: Array[String] = ["pistol", "machine gun", "sniper"] # Array for easy indexing
var gun_keys: Array[String] = ["pistol", "machine gun", "sniper", "shotgun", "rocket launcher"] # Array for easy indexing
var curr_gun_index: int = 0  # Index into gun_keys array
var curr_gun: Gun = null
# Defaulted to normal projectile
var curr_projectile_spec: ProjectileSpec = projectile_library["normal"]

var gun_textures: Dictionary = {
	"pistol": preload("res://assets/pistol_sprite_2.png"),
	"machine gun": preload("res://assets/machinegun_sprite.png"), #TODO: change to machine gun
	"sniper": preload("res://assets/sniper_sprite.png")
}

# Gun specific offsets when facing right
var gun_offsets_right: Dictionary = {
	"pistol": Vector2(-90, 20),
	"machine gun": Vector2(-40, 25),
	"sniper": Vector2(0, 0),
	"shotgun": Vector2(0, 0), 
	"rocket launcher": Vector2(0, 0)
}

# Gun specific offsets when facing right
var gun_offsets_left: Dictionary = {
	"pistol": Vector2(90, 20),
	"machine gun": Vector2(40, 25),
	"sniper": Vector2(0, 0),
	"shotgun": Vector2(0, 0), 
	"rocket launcher": Vector2(0, 0)
}

# Rotation pivot location
var gun_sprite_positions: Dictionary = {
	"pistol": Vector2(-20, 0),
	"machine gun": Vector2(-175, 0),
	"sniper": Vector2(-200, 0),
	"shotgun": Vector2(0, 0), 
	"rocket launcher": Vector2(0, 0)
}

# Projectile spawn location
var projectile_spawn_offsets: Dictionary = {
	"pistol": Vector2(50, 0),
	"machine gun": Vector2(250, -2),
	"sniper": Vector2(430, 20),
	"shotgun": Vector2(430, 20), 
	"rocket launcher": Vector2(430, 20)
}

# we don't want to read inputs if the gun manager belongs to an npc
var npc: bool = false

#TODO: don't hardcode the guns in the gun manager

func _ready() -> void:
	#guns = {
		#"pistol": Pistol.new(),
		#"machine gun": MachineGun.new(),
		#"sniper": Sniper.new(),
	#}
	guns = {
		"pistol": Pistol.new(),
		"machine gun": MachineGun.new(),
		"sniper": Sniper.new(),
		"shotgun": Shotgun.new(),
		"rocket launcher": RocketLauncher.new()
	}
	
	# Create index for current gun for easy switching
	curr_gun = guns[gun_keys[curr_gun_index]]
	curr_projectile_spec = projectile_library[curr_gun.projectile_type]  # Set based on gun
	_update_gun_texture()
	_update_projectile_spawn_position()

func _process(_delta: float) -> void:
	_time_since_last_shot += _delta
	
	if not npc:
		if Input.is_action_just_pressed("switch_gun"):
			curr_gun_index = (curr_gun_index + 1) % guns.size()
			curr_gun = guns[curr_gun_index]

		if Input.is_action_just_pressed("shoot") and _time_since_last_shot >= curr_gun.shot_delay:
			shoot()
			_time_since_last_shot = 0.0


func shoot() -> void:
	var projectile: Projectile = _projectile_scene.instantiate()
	projectile.global_position = projectile_spawn.global_position
	var mouse_pos = get_global_mouse_position()
	var player_position = global_position
	var mouse_direction = mouse_pos.x - player_position.x
	var curr_gun_key = gun_keys[curr_gun_index]
	
	# If player is moving right
	if player.velocity.x > 0 or default_state:
		scale.y = 1
		position = gun_offsets_left[curr_gun_key]
		facing_right = true
		default_state = false
		
	# If player is moving left	
	elif player.velocity.x < 0 or mouse_direction < 0:
		scale.y = -1
		position = gun_offsets_right[curr_gun_key]
		facing_right = false
		default_state = false
		
	# If player is moving left	
	elif mouse_direction > 100 and player.velocity.x == 0:
		scale.y = 1
		position = gun_offsets_left[curr_gun_key]
		facing_right = true
		default_state = false
		
	# If player is looking right
	elif mouse_direction < -100 and player.velocity.x == 0:
		scale.y = -1
		position = gun_offsets_right[curr_gun_key]
		facing_right = false
		default_state = false
		
	rotation_pivot.look_at(mouse_pos)
		
	if facing_right:
		# When facing right, limit rotation
		rotation_pivot.rotation = clamp(rotation_pivot.rotation, -1.5, 1.5)
	else:
		# When facing left, limit rotation
		var abs_rotation = abs(rotation_pivot.rotation)
		abs_rotation = clamp(abs_rotation, 1.5, 5)
		rotation_pivot.rotation = sign(rotation_pivot.rotation) * abs_rotation
		
	if Input.is_action_just_pressed("switch_gun"):
		curr_gun_index = (curr_gun_index + 1) % gun_keys.size()
		var new_gun_key = gun_keys[curr_gun_index]  # Get new key after incrementing
		curr_gun = guns[new_gun_key]  # Use new key
		curr_projectile_spec = projectile_library[curr_gun.projectile_type]  # Update projectile
		_update_gun_texture()
		_update_projectile_spawn_position()
			
	# Add logic here for switching projectiles (Rytham will do this later)
		
	var should_shoot := false
	if curr_gun.firing_mode == Gun.FiringMode.SEMI_AUTO:
		should_shoot = Input.is_action_just_pressed("shoot")
	elif curr_gun.firing_mode == Gun.FiringMode.AUTO:
		should_shoot = Input.is_action_pressed("shoot")
	
	if should_shoot and _time_since_last_shot >= curr_gun.shot_delay:
		_shoot()
		_time_since_last_shot = 0.0


func _shoot() -> void:
	var projectile_damage = curr_projectile_spec.damage
	var multiplier = curr_gun.dmg_multiplier 
	var damage = projectile_damage * multiplier
	var base_direction: Vector2 = projectile_spawn.global_transform.x.normalized()
	
	for i in range(curr_gun.projectile_count):
		var projectile = projectile_factory.create_projectile(curr_projectile_spec, damage)
		projectile.global_position = projectile_spawn.global_position
		projectile.rotation = projectile_spawn.global_rotation
		
		var angle_offset := 0.0
		if curr_gun.projectile_count > 1:
			var step := curr_gun.spread_angle / (curr_gun.projectile_count - 1)
			angle_offset = -curr_gun.spread_angle / 2.0 + (i * step)
		
		var direction := base_direction.rotated(deg_to_rad(angle_offset))
		projectile.linear_velocity = direction * curr_gun.projectile_speed
		
		#for child in projectile.get_children():
			#child.scale = curr_gun.projectile_scale
		
		self.get_tree().current_scene.add_child(projectile)
	
	camera.add_shake(0.17)
	

func _update_gun_texture() -> void:
	var curr_gun_key = gun_keys[curr_gun_index]
	
	if gun_sprite and gun_textures.has(curr_gun_key):
		gun_sprite.texture = gun_textures[curr_gun_key]
		gun_sprite.position = gun_sprite_positions[curr_gun_key]
	else:
		push_error("Invalid gun index or gun_sprite not found: " + str(curr_gun_key))
		

func _update_projectile_spawn_position() -> void:
	var curr_gun_key = gun_keys[curr_gun_index]
	
	if projectile_spawn and projectile_spawn_offsets.has(curr_gun_key):
		projectile_spawn.position = projectile_spawn_offsets[curr_gun_key]
	else:
		push_error("Invalid gun index or projectile_spawn not found: " + str(curr_gun_key))
