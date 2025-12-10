class_name GunManager
extends Node2D

const GunSpec = preload("res://specs/gun_spec.gd")

@onready var shooting_sound: AudioStreamPlayer2D = $shooting_sound
@onready var rotation_pivot: Node2D = $RotationPivot
@onready var projectile_spawn: Node2D = $RotationPivot/ProjectileSpawn
@onready var gun_sprite: Sprite2D = $RotationPivot/Sprite2D
@onready var camera: Camera2D = get_parent().get_parent().get_node("Camera2D") as Camera2D
@onready var player: CharacterBody2D = get_parent().get_parent()

@export var offset_right: Vector2 = Vector2(-90, 20)
@export var offset_left: Vector2 = Vector2(90, 20)
@export var reload_time: float = 0.0

var _projectile_scene = preload("res://scenes/projectiles/projectile.tscn")

var projectile_library = {
	"normal": preload("res://specs/projectiles/normal_projectile.tres"),
	"laser":  preload("res://specs/projectiles/laser_projectile.tres"),
	"rocket": preload("res://specs/projectiles/rocket_projectile.tres")
}

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
	
var gun_keys: Array[String] = ["pistol", "machine gun", "shotgun", "rocket launcher", "sniper"]
var curr_gun_index: int = 0
var curr_gun: Gun = null
var curr_projectile_spec: ProjectileSpec = projectile_library["normal"]

# ammo variables
var ammo_in_mag: Dictionary = {}
var ammo_in_reserve: Dictionary = {}
var is_reloading: bool = false

var default_gun_texture: Texture2D = preload("res://assets/placeholder_gun.svg")

var gun_textures: Dictionary = GunData.gun_textures
var gun_offsets_right: Dictionary = GunData.gun_offsets_right
var gun_offsets_left: Dictionary = GunData.gun_offsets_left
var gun_sprite_positions: Dictionary = GunData.gun_sprite_positions
var projectile_spawn_offsets: Dictionary = GunData.projectile_spawn_offsets
var fusion_recipes: Dictionary = GunData.fusion_recipes
var fusion_gun_classes: Dictionary = GunData.fusion_gun_classes

var npc: bool = false

func _ready() -> void:
	curr_gun = guns[gun_keys[curr_gun_index]]
	curr_projectile_spec = projectile_library[curr_gun.projectile_type]
	_update_gun_texture()
	_update_projectile_spawn_position()
	
	for gun in guns:
		ammo_in_mag[gun] = guns[gun].magazine_size
		ammo_in_reserve[gun] = guns[gun].starting_reserve

func _process(delta: float) -> void:
	_time_since_last_shot += delta
	
	# Let laser guns handle their own cooling
	if curr_gun is LaserGun:
		var laser_gun = curr_gun as LaserGun
		laser_gun.cool_down(delta)
		
		# Update charging if gun is chargeable
		if laser_gun.is_chargeable and laser_gun.is_charging:
			laser_gun.update_charge(delta)
	
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
	
	# Handle facing direction
	if mouse_direction > 100:
		scale.y = 1
		position = gun_offsets_left.get(curr_gun_key, offset_left)
		facing_right = true
		default_state = false
	elif mouse_direction < -100:
		scale.y = -1
		position = gun_offsets_right.get(curr_gun_key, offset_right)
		facing_right = false
		default_state = false
	elif player.velocity.x > 0 or default_state:
		scale.y = 1
		position = gun_offsets_left.get(curr_gun_key, offset_left)
		facing_right = true
		default_state = false
	elif player.velocity.x < 0 or mouse_direction < 0:
		scale.y = -1
		position = gun_offsets_right.get(curr_gun_key, offset_right)
		facing_right = false
		default_state = false

	rotation_pivot.look_at(mouse_pos)
		
	if facing_right:
		rotation_pivot.rotation = clamp(rotation_pivot.rotation, -1.5, 1.5)
	else:
		var abs_rotation = abs(rotation_pivot.rotation)
		abs_rotation = clamp(abs_rotation, 1.5, 5)
		rotation_pivot.rotation = sign(rotation_pivot.rotation) * abs_rotation
		
	if Input.is_action_just_pressed("switch_gun"):
		# Reset charge when switching guns
		if curr_gun is LaserGun:
			(curr_gun as LaserGun).reset_charge()
		
		curr_gun_index = (curr_gun_index + 1) % gun_keys.size()
		var new_gun_key = gun_keys[curr_gun_index]
		curr_gun = guns[new_gun_key]
		curr_projectile_spec = projectile_library[curr_gun.projectile_type]
		_update_gun_texture()
		_update_projectile_spawn_position()
		_time_since_last_shot = curr_gun.shot_delay
		reload_time = guns[new_gun_key].reload_time
	
	var inventory = get_tree().get_first_node_in_group("inventory") as InventoryUI
	var inventory_open = inventory != null and inventory.is_open
	
	if not inventory_open:
		_handle_shooting(delta, curr_gun_key)

func _handle_shooting(delta: float, curr_gun_key: String) -> void:
	var is_laser_gun = curr_gun is LaserGun
	var laser_gun: LaserGun = curr_gun as LaserGun if is_laser_gun else null
	
	var shoot_pressed = Input.is_action_pressed("shoot")
	var shoot_just_pressed = Input.is_action_just_pressed("shoot")
	var shoot_just_released = Input.is_action_just_released("shoot")
	
	# Handle chargeable guns
	if is_laser_gun and laser_gun.is_chargeable:
		if shoot_pressed:
			laser_gun.start_charging()
		
		if shoot_just_released and laser_gun.is_charging:
			# Fire charged shot
			if laser_gun.can_shoot():
				_shoot_charged()
				_time_since_last_shot = 0.0
			laser_gun.reset_charge()
		return  # Don't process normal shooting for chargeable guns
	
	# Normal shooting logic for non-chargeable guns
	var should_shoot := false
	var mag_size: int = guns[curr_gun_key].magazine_size
	var curr_mag: int = ammo_in_mag.get(curr_gun_key, 0)
	var curr_reserve: int = ammo_in_reserve.get(curr_gun_key, 0)
	
	if curr_gun.firing_mode == Gun.FiringMode.SEMI_AUTO:
		should_shoot = shoot_just_pressed
	elif curr_gun.firing_mode == Gun.FiringMode.AUTO:
		should_shoot = shoot_pressed
	
	# Handle reload
	if Input.is_action_just_pressed("reload") and not is_laser_gun:
		reload_time = guns[curr_gun_key].reload_time
		_start_reload(curr_gun_key, mag_size, curr_mag, curr_reserve)
	
	# Shooting logic
	if should_shoot and not is_reloading:
		var current_shot_delay = curr_gun.shot_delay
		if is_laser_gun:
			current_shot_delay = laser_gun.get_current_shot_delay()
		
		if is_laser_gun:
			if laser_gun.can_shoot() and _time_since_last_shot >= current_shot_delay:
				_shoot()
				_time_since_last_shot = 0.0
		else:
			# Regular guns use ammo
			if curr_mag >= 1:
				if _time_since_last_shot >= curr_gun.shot_delay:
					_shoot()
					_time_since_last_shot = 0.0
					ammo_in_mag[curr_gun_key] = curr_mag - 1
			else:
				if curr_reserve > 0:
					_start_reload(curr_gun_key, mag_size, curr_mag, curr_reserve)
				else:
					_no_ammo_fire()

func _shoot_charged() -> void:
	var projectile_damage = curr_projectile_spec.damage
	var gun_sound = curr_gun.shoot_sound
	var base_direction: Vector2 = projectile_spawn.global_transform.x.normalized()
	var laser_gun = curr_gun as LaserGun
	
	# Special handling for laser shotgun
	if curr_gun is LaserShotgun:
		var shotgun = curr_gun as LaserShotgun
		var proj_count = shotgun.get_charged_projectile_count()
		var spread = shotgun.get_charged_spread()
		var damage_mult = shotgun.get_charged_damage_multiplier()
		var damage = projectile_damage * damage_mult
		
		for i in range(proj_count):
			var projectile = projectile_factory.create_projectile(curr_projectile_spec, damage)
			projectile.global_position = projectile_spawn.global_position
			projectile.rotation = projectile_spawn.global_rotation
			
			var angle_offset: float = 0.0
			if proj_count > 1:
				var step: float = spread / float(proj_count - 1)
				angle_offset = -spread / 2.0 + (float(i) * step)
			
			var direction := base_direction.rotated(deg_to_rad(angle_offset))
			projectile.linear_velocity = direction * curr_gun.projectile_speed
			
			self.get_tree().current_scene.add_child(projectile)
		
		shotgun.add_heat(shotgun.heat_per_shot)
		camera.add_shake(0.25)
	else:
		# Regular charged shot (sniper)
		var damage_mult = laser_gun.get_charged_damage_multiplier()
		var damage = projectile_damage * damage_mult
		var heat = laser_gun.get_charged_heat()
		
		var projectile = projectile_factory.create_projectile(curr_projectile_spec, damage)
		projectile.global_position = projectile_spawn.global_position
		projectile.rotation = projectile_spawn.global_rotation
		projectile.linear_velocity = base_direction * curr_gun.projectile_speed
		
		laser_gun.add_heat(heat)
		
		self.get_tree().current_scene.add_child(projectile)
		camera.add_shake(0.3)
	
	shooting_sound.stream = gun_sound
	shooting_sound.play()

func _shoot() -> void:
	var projectile_damage = curr_projectile_spec.damage
	var gun_sound = curr_gun.shoot_sound
	var multiplier = curr_gun.dmg_multiplier 
	var damage = projectile_damage * multiplier
	var base_direction: Vector2 = projectile_spawn.global_transform.x.normalized()
	
	var is_laser_gun = curr_gun is LaserGun
	var laser_gun: LaserGun = curr_gun as LaserGun if is_laser_gun else null
	
	# Get spread (affected by heat for laser guns)
	var spread_angle = curr_gun.spread_angle
	if is_laser_gun:
		spread_angle = laser_gun.get_current_spread()
	
	for i in range(curr_gun.projectile_count):
		var projectile = projectile_factory.create_projectile(curr_projectile_spec, damage)
		projectile.global_position = projectile_spawn.global_position
		projectile.rotation = projectile_spawn.global_rotation
		
		var angle_offset: float = 0.0
		if curr_gun.projectile_count > 1:
			var step: float = spread_angle / float(curr_gun.projectile_count - 1)
			angle_offset = -spread_angle / 2.0 + (float(i) * step)
		
		var direction := base_direction.rotated(deg_to_rad(angle_offset))
		projectile.linear_velocity = direction * curr_gun.projectile_speed
		
		self.get_tree().current_scene.add_child(projectile)
	
	# Add heat for laser guns
	if is_laser_gun:
		laser_gun.add_heat(laser_gun.heat_per_shot)
	
	shooting_sound.stream = gun_sound
	shooting_sound.play()
	camera.add_shake(0.17)

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

	var first_index: int = gun_keys.find(first_gun_key)
	if first_index != -1:
		gun_keys.remove_at(first_index)

	var second_index: int = gun_keys.find(second_gun_key)
	if second_index != -1:
		gun_keys.remove_at(second_index)

	guns[fusion_gun_key] = fusion_gun_instance
	gun_keys.append(fusion_gun_key)

	ammo_in_mag[fusion_gun_key] = fusion_gun_instance.magazine_size
	ammo_in_reserve[fusion_gun_key] = fusion_gun_instance.starting_reserve

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

func _start_reload(gun_key: String, mag_size: int, curr_mag: int, curr_reserve: int) -> void:
	if is_reloading:
		return
	if curr_mag >= mag_size:
		return
	if curr_reserve <= 0:
		return
	
	is_reloading = true
	await get_tree().create_timer(reload_time).timeout
	_finish_reload(gun_key)

func _finish_reload(gun_key: String) -> void:
	if not guns.has(gun_key):
		is_reloading = false
		return
	var mag_size: int = guns[gun_key].magazine_size
	var mag: int = int(ammo_in_mag.get(gun_key, 0))
	var reserve: int = int(ammo_in_reserve.get(gun_key, 0))
	var needed: int = mag_size - mag
	
	if needed <= 0:
		is_reloading = false
		return
	
	var taken: int = min(needed, reserve)
	mag += taken
	ammo_in_mag[gun_key] = mag
	is_reloading = false

func _no_ammo_fire() -> void:
	pass

func _update_gun_texture() -> void:
	var curr_gun_key = gun_keys[curr_gun_index]
	
	if gun_sprite and gun_textures.has(curr_gun_key):
		gun_sprite.texture = gun_textures[curr_gun_key]
		gun_sprite.position = gun_sprite_positions.get(curr_gun_key, Vector2.ZERO)
	else:
		push_error("Invalid gun index or gun_sprite not found: " + str(curr_gun_key))

func _update_projectile_spawn_position() -> void:
	var curr_gun_key = gun_keys[curr_gun_index]
	
	if projectile_spawn:
		projectile_spawn.position = projectile_spawn_offsets.get(curr_gun_key, Vector2(50, 0))
	else:
		push_error("Invalid gun index or projectile_spawn not found: " + str(curr_gun_key))

func get_fusion_result(gun_key_1: String, gun_key_2: String) -> String:
	var recipe_key_1 = gun_key_1 + "+" + gun_key_2
	var recipe_key_2 = gun_key_2 + "+" + gun_key_1
	
	if fusion_recipes.has(recipe_key_1):
		return fusion_recipes[recipe_key_1]
	elif fusion_recipes.has(recipe_key_2):
		return fusion_recipes[recipe_key_2]
	
	return ""

# UI Helper methods - delegate to gun
func get_current_heat() -> float:
	if curr_gun is LaserGun:
		return (curr_gun as LaserGun).current_heat
	return 0.0

func get_max_heat() -> float:
	if curr_gun is LaserGun:
		return (curr_gun as LaserGun).max_heat
	return 100.0

func is_gun_overheated() -> bool:
	if curr_gun is LaserGun:
		return (curr_gun as LaserGun).is_overheated
	return false

func get_charge_percentage() -> float:
	if curr_gun is LaserGun:
		return (curr_gun as LaserGun).get_charge_percentage()
	return 0.0

func is_gun_charging() -> bool:
	if curr_gun is LaserGun:
		return (curr_gun as LaserGun).is_charging
	return false
