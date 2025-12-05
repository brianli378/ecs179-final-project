class_name GunManager
extends Node2D

const GunSpec = preload("res://scripts/gun_spec.gd")

# reference for spx_shoot to update it based on projectile spec
@onready var shooting_sound: AudioStreamPlayer2D = $shooting_sound
# Rotation pivot node was just added because godot is being mean about
# me changing the rotation pivot of a gun.
@onready var rotation_pivot: Node2D = $RotationPivot
@onready var projectile_spawn: Node2D = $RotationPivot/ProjectileSpawn
@onready var gun_sprite: Sprite2D = $RotationPivot/Sprite2D
@onready var camera: Camera2D = get_parent().get_parent().get_node("Camera2D") as Camera2D
@onready var player: CharacterBody2D = get_parent().get_parent()

@export var offset_right: Vector2 = Vector2(-90, 20)
@export var offset_left: Vector2 = Vector2(90, 20)
@export var reload_time: float = 0.0

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

var guns: Dictionary = {
	"pistol": Pistol.new(),
	"machine gun": MachineGun.new(),
	"sniper": Sniper.new(),
	"shotgun": Shotgun.new(),
	"rocket launcher": RocketLauncher.new()
}
	
var gun_keys: Array[String] = ["pistol", "machine gun", "sniper", "shotgun", "rocket launcher"] # Array for easy indexing
var curr_gun_index: int = 0  # Index into gun_keys array
var curr_gun: Gun = null
# Defaulted to normal projectile
var curr_projectile_spec: ProjectileSpec = projectile_library["normal"]

# ammo variables
var ammo_in_mag: Dictionary = {}
var ammo_in_reserve: Dictionary = {}
var is_reloading: bool = false

var default_gun_texture: Texture2D = preload("res://assets/placeholder_gun.svg")

var gun_textures: Dictionary = {
	# base guns
	"pistol": preload("res://assets/guns/pistol_sprite_2.png"),
	"machine gun": preload("res://assets/guns/machinegun_sprite.png"), 
	"sniper": preload("res://assets/guns/sniper_sprite.png"),
	"shotgun": preload("res://assets/guns/shotgun_sprite.png"),
	"rocket launcher": preload("res://assets/guns/rocket_launcher_sprite.png"),
	
	# pistol fusions
	"potgun": preload("res://assets/guns/potgun_sprite.png"),
	"pocket launcher": preload("res://assets/guns/pocket_launcher_sprite.png"),
	"piper": preload("res://assets/guns/piper_sprite.png"),
	"pachine gun": preload("res://assets/guns/pistol_sprite_2.png"),
	
	# shotgun fusions
	"shistol": preload("res://assets/guns/shotgun_sprite.png"),
	"shocket launcher": preload("res://assets/guns/shotgun_sprite.png"),
	"shiper": preload("res://assets/guns/shotgun_sprite.png"),
	"shachine gun": preload("res://assets/guns/shotgun_sprite.png"),
	
	# rocket launcher fusions
	"rocket pistol": preload("res://assets/guns/rocket_launcher_sprite.png"),
	"rocket shotgun":  preload("res://assets/guns/rocket_launcher_sprite.png"),
	"rocket sniper":  preload("res://assets/guns/rocket_launcher_sprite.png"),
	"rockchine gun":  preload("res://assets/guns/rocket_launcher_sprite.png"),
	
	# sniper fusions
	"laser pistol": preload("res://assets/guns/sniper_sprite.png"),
	"laser shotgun": preload("res://assets/guns/sniper_sprite.png"),
	"laser rocket launcher": preload("res://assets/guns/sniper_sprite.png"),
	"laser machine gun": preload("res://assets/guns/sniper_sprite.png"),
	
	# machine gun fusions
	"machine pistol": preload("res://assets/guns/machinegun_sprite.png"), 
	"machinegungun": preload("res://assets/guns/machinegun_sprite.png"), 
	"machine launcher": preload("res://assets/guns/machinegun_sprite.png"), 
	"machine-per": preload("res://assets/guns/machinegun_sprite.png")
	
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
	"rocket launcher": Vector2(-200, -60)
}

# Projectile spawn location
var projectile_spawn_offsets: Dictionary = {
	"pistol": Vector2(50, 0),
	"machine gun": Vector2(120, 20),
	"sniper": Vector2(430, 20),
	"shotgun": Vector2(250, 0), 
	"rocket launcher": Vector2(250, 25)
}

# we don't want to read inputs if the gun manager belongs to an npc
var npc: bool = false

#TODO: don't hardcode the guns in the gun manager

# FUSION LOGIC
var fusion_recipes: Dictionary = {
	"pistol+shotgun": "potgun",
	"pistol+rocket launcher": "pocket launcher",
	"pistol+sniper": "piper",
	"pistol+machine gun": "pachine gun",
	"shotgun+pistol": "shistol",
	"shotgun+rocket launcher": "shocket launcher",
	"shotgun+sniper": "shiper",
	"shotgun+machine gun": "shachine gun",
	"rocket launcher+pistol": "rocket pistol",
	"rocket launcher+shotgun": "rocket shotgun",
	"rocket launcher+sniper": "rocket sniper",
	"rocket launcher+machine gun": "rockchine gun",
	"sniper+pistol": "laser pistol",
	"sniper+shotgun": "laser shotgun",
	"sniper+rocket launcher": "laser rocket launcher",
	"sniper+machine gun": "laser machine gun",
	"machine gun+pistol": "machine pistol",
	"machine gun+shotgun": "machinegun gun",
	"machine gun+rocket launcher": "machine launcher",
	"machine gun+sniper": "machineper"
}

var fusion_gun_classes: Dictionary = {
	"potgun": Potgun,
	"pocket launcher": PocketLauncher,
	"piper": Piper,
	"pachine gun": PachineGun,
	"shistol": Shistol,
	"shocket launcher": ShocketLauncher,
	"shiper": Shiper,
	"shachine gun": ShachineGun,
	"rocket pistol": RocketPistol,
	"rocket shotgun": RocketShotgun,
	"rocket sniper": RocketSniper,
	"rockchine gun": RockchineGun,
	"laser pistol": LaserPistol,
	"laser shotgun": LaserShotgun,
	"laser rocket launcher": LaserRocketLauncher,
	"laser machine gun": LaserMachineGun,
	"machine pistol": MachinePistol,
	"machinegun gun": MachineGunGun,
	"machine launcher": MachineLauncher,
	"machineper": Machineper
}


func _ready() -> void:
	#guns = {
		#"pistol": Pistol.new(),
		#"machine gun": MachineGun.new(),
		#"sniper": Sniper.new(),
		#"shotgun": Shotgun.new(),
		#"rocket launcher": RocketLauncher.new()
	#}
	
	# Create index for current gun for easy switching
	curr_gun = guns[gun_keys[curr_gun_index]]
	curr_projectile_spec = projectile_library[curr_gun.projectile_type]  # Set based on gun
	_update_gun_texture()
	_update_projectile_spawn_position()
	
	# initialize ammo
	#for gun_key in gun_keys:
		#var stats := GunSpec.get_stats(gun_key)
		#ammo_in_mag[gun_key] = int(stats.magazine_size)
		#ammo_in_reserve[gun_key] = int(stats.starting_reserve)
	for gun in guns:
		ammo_in_mag[gun] = guns[gun].magazine_size
		ammo_in_reserve[gun] = guns[gun].starting_reserve


func _process(_delta: float) -> void:
	_time_since_last_shot += _delta
	var mouse_pos = get_global_mouse_position()
	var player_position = global_position
	var mouse_direction = mouse_pos.x - player_position.x
	var curr_gun_key = gun_keys[curr_gun_index]
	
	if not guns.has(curr_gun_key):
		if gun_keys.size() == 0:
			return
		for gun_key in gun_keys:
			if guns.has(gun_key):
				curr_gun_index = gun_keys.find(gun_key)
				curr_gun_key = gun_key
				curr_gun = guns[gun_key]
				curr_projectile_spec = projectile_library[curr_gun.projectile_type]
				_update_gun_texture()
				_update_projectile_spawn_position()
				break
		if not guns.has(curr_gun_key):
			return
	
	# If player is looking left	
	if mouse_direction > 100 :
		scale.y = 1
		position = gun_offsets_left[curr_gun_key]
		facing_right = true
		default_state = false
		
	# If player is looking right
	elif mouse_direction < -100:
		scale.y = -1
		position = gun_offsets_right[curr_gun_key]
		facing_right = false
		default_state = false
		
	# If player is moving right
	elif player.velocity.x > 0 or default_state:
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
		_time_since_last_shot = curr_gun.shot_delay
		
		#var stats = GunSpec.get_stats(new_gun_key)
		#reload_time = float(stats.reload_time)
		reload_time = guns[new_gun_key].reload_time

	# Add logic here for switching projectiles (Rytham will do this later)
		
	var should_shoot := false
	if curr_gun.firing_mode == Gun.FiringMode.SEMI_AUTO:
		should_shoot = Input.is_action_just_pressed("shoot")
	elif curr_gun.firing_mode == Gun.FiringMode.AUTO:
		should_shoot = Input.is_action_pressed("shoot")

	#var stats := GunSpec.get_stats(curr_gun_key)
	#var mag_size: int = int(stats.magazine_size)
	var mag_size: int = guns[curr_gun_key].magazine_size
	#reload_time = float(stats.reload_time)
	reload_time = guns[curr_gun_key].reload_time
	var curr_mag: int = ammo_in_mag.get(curr_gun_key, 0)
	var curr_reserve: int = ammo_in_reserve.get(curr_gun_key, 0)
	var reload_pressed := Input.is_action_just_pressed("reload")
	if reload_pressed:
		_start_reload(curr_gun_key, mag_size, curr_mag, curr_reserve)

	if should_shoot and not is_reloading:
		if curr_mag > 0:
			if _time_since_last_shot >= curr_gun.shot_delay:
				_shoot()
				_time_since_last_shot = 0.0
				ammo_in_mag[curr_gun_key] = curr_mag - 1
		else:
			# auto reload
			if curr_reserve > 0:
				_start_reload(curr_gun_key, mag_size, curr_mag, curr_reserve)
			else:
				_no_ammo_fire()
				


func shoot() -> void:
	var projectile: Projectile = _projectile_scene.instantiate()
	
	# make sure the projectile didn't instantly get destroyed
	projectile.global_position = projectile_spawn.global_position


func fuse_guns(first_gun_key: String, second_gun_key: String) -> String:
	if not guns.has(first_gun_key) or not guns.has(second_gun_key):
		return ""

	var recipe_key: String = first_gun_key + "+" + second_gun_key
	if not fusion_recipes.has(recipe_key):
		return ""

	var fusion_gun_key: String = fusion_recipes[recipe_key]
	var fusion_gun_instance: Gun = _create_fusion_gun_instance(fusion_gun_key)
	if fusion_gun_instance == null:
		return ""

	ammo_in_mag.erase(first_gun_key)
	ammo_in_mag.erase(second_gun_key)
	ammo_in_reserve.erase(first_gun_key)
	ammo_in_reserve.erase(second_gun_key)

	guns.erase(first_gun_key)
	guns.erase(second_gun_key)

	var first_index: int = gun_keys.find(first_gun_key)
	if first_index != -1:
		gun_keys.remove_at(first_index)

	var second_index: int = gun_keys.find(second_gun_key)
	if second_index != -1:
		if second_index > first_index and first_index != -1:
			second_index -= 1
		gun_keys.remove_at(second_index)

	guns[fusion_gun_key] = fusion_gun_instance
	gun_keys.append(fusion_gun_key)

	ammo_in_mag[fusion_gun_key] = fusion_gun_instance.magazine_size
	ammo_in_reserve[fusion_gun_key] = fusion_gun_instance.starting_reserve

	_copy_gun_offsets(first_gun_key, fusion_gun_key)

	if gun_keys.size() > 0:
		curr_gun_index = gun_keys.find(fusion_gun_key)
		if curr_gun_index == -1:
			curr_gun_index = 0
		var curr_gun_key: String = gun_keys[curr_gun_index]
		curr_gun = guns[curr_gun_key]
		curr_projectile_spec = projectile_library[curr_gun.projectile_type]
		_update_gun_texture()
		_update_projectile_spawn_position()

	return fusion_gun_key


func get_owned_gun_keys() -> Array[String]:
	return gun_keys.duplicate()


func get_gun_texture(gun_key: String) -> Texture2D:
	if gun_textures.has(gun_key):
		return gun_textures[gun_key]
	return default_gun_texture


func _create_fusion_gun_instance(fusion_gun_key: String) -> Gun:
	if not fusion_gun_classes.has(fusion_gun_key):
		return null
	var gun_class = fusion_gun_classes[fusion_gun_key]
	return gun_class.new()


func _copy_gun_offsets(source_gun_key: String, new_gun_key: String) -> void:
	if gun_offsets_right.has(source_gun_key):
		gun_offsets_right[new_gun_key] = gun_offsets_right[source_gun_key]
	if gun_offsets_left.has(source_gun_key):
		gun_offsets_left[new_gun_key] = gun_offsets_left[source_gun_key]
	if gun_sprite_positions.has(source_gun_key):
		gun_sprite_positions[new_gun_key] = gun_sprite_positions[source_gun_key]
	if projectile_spawn_offsets.has(source_gun_key):
		projectile_spawn_offsets[new_gun_key] = projectile_spawn_offsets[source_gun_key]
	

func _start_reload(gun_key: String, mag_size: int, curr_mag: int, curr_reserve: int) -> void:
	if is_reloading:
		return
	if curr_mag >= mag_size:
		return
	if curr_reserve <= 0:
		return
	
	is_reloading = true
	# reload sound goes here
	await get_tree().create_timer(reload_time).timeout
	_finish_reload(gun_key)


func _finish_reload(gun_key: String) -> void:
	if not guns.has(gun_key):
		is_reloading = false
		return
	#var stats = GunSpec.get_stats(gun_key)
	#var mag_size: int = int(stats.magazine_size)
	var mag_size: int = guns[gun_key].magazine_size
	var mag: int = int(ammo_in_mag.get(gun_key, 0))
	var reserve: int = int(ammo_in_reserve.get(gun_key, 0))
	var needed: int = mag_size - mag
	
	if needed <= 0:
		is_reloading = false
		return
	
	var taken: int = min(needed, reserve)
	mag += taken
	reserve -= taken
	ammo_in_mag[gun_key] = mag
	ammo_in_reserve[gun_key] = reserve
	is_reloading = false


func _no_ammo_fire() -> void:
	# sound for when you shoot with empty gun (or anything else we should add for that) goes here
	pass


func _shoot() -> void:
	var projectile_damage = curr_projectile_spec.damage
	var gun_sound = curr_gun.shoot_sound
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
		
		shooting_sound.stream = gun_sound
		shooting_sound.play()
		
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
