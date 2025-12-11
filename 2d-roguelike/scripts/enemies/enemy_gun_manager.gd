class_name EnemyGunManager
extends Node2D

var curr_projectile_spec: ProjectileSpec = null

var curr_gun: Gun = null

# the 5 fusion guns we have in rotation for the boss
const POTENTIAL_FUSION_GUN_KEYS: Array[String] = ["pachine gun", "shocket launcher", "rocket sniper", "laser shotgun", "machineper"]

var gun_keys: Array[String] = ['pistol'] # Array for easy indexing
var curr_gun_index: int = 0  # Index into gun_keys array

# ammo variables
var ammo_in_mag: Dictionary = {}
var ammo_in_reserve: Dictionary = {}
var is_reloading: bool = false

var default_gun_texture: Texture2D = preload("res://assets/placeholder_gun.svg")

# replaced with values from GunData
var gun_offsets_right: Dictionary = GunData.gun_offsets_right.duplicate(true)
var gun_offsets_left: Dictionary = GunData.gun_offsets_left.duplicate(true)
var gun_sprite_positions: Dictionary = GunData.gun_sprite_positions.duplicate(true)
var projectile_spawn_offsets: Dictionary = GunData.projectile_spawn_offsets.duplicate(true)
var gun_textures: Dictionary = GunData.gun_textures.duplicate(true)
var fusion_recipes: Dictionary = GunData.fusion_recipes.duplicate(true)  # only if you modify it
var fusion_gun_classes: Dictionary = GunData.fusion_gun_classes.duplicate(true) # only if you modify it
var basic_enemy_gun_offsets_x: Dictionary = GunData.basic_enemy_gun_offsets_x.duplicate(true)
var base_weapon_to_projectile: Dictionary = GunData.base_weapon_to_projectile.duplicate(true)
var boss_gun_offsets: Dictionary = GunData.boss_gun_offsets.duplicate(true)
var boss_projectile_spawn_offsets: Dictionary = GunData.boss_projectile_spawn_offsets.duplicate(true)

var guns_for_player: Array[String] = []
var _time_since_last_shot: float = 0.0

@onready 
var shooting_sound: AudioStreamPlayer2D = $shooting_sound

@onready 
var projectile_spawn: Node2D = $RotationPivot/ProjectileSpawn

@onready 
var _player: Player = null

@onready 
var enemy: Enemy = get_parent().get_parent()

@onready 
var rotation_pivot: Node2D = $RotationPivot

@onready
var gun_sprite: Sprite2D = $RotationPivot/GunSprite

@onready
var line_of_sight : EnemyLineOfSight = $EnemyLineOfSight

func setup_fusion_gun_for_boss() -> String:
	var _fusion_gun_key: String = POTENTIAL_FUSION_GUN_KEYS.pick_random()
	
	print("boss gun: " + _fusion_gun_key)
	
	# figure out what guns make up our fusion
	var _gun_recipe: String = fusion_recipes.find_key(_fusion_gun_key)
	var _component_gun_keys: PackedStringArray = _gun_recipe.split("+")
	
	# set the guns we're going to give to the player when the boss dies
	guns_for_player = [_component_gun_keys.get(0), _component_gun_keys.get(1)]
	
	
	var fusion_gun_instance: Gun = null
	
	# create the instance and add it to the shared resource if we don't have it already
	if not (_fusion_gun_key in GunData.guns):
		fusion_gun_instance = _create_fusion_gun_instance(_fusion_gun_key)
		
		# if we failed then return
		if fusion_gun_instance == null:
			return ""
		
		# cache the instance for later
		GunData.guns[_fusion_gun_key] = fusion_gun_instance
	else:
		# fusion gun already exists in shared resource, we'll just grab it
		fusion_gun_instance = GunData.guns[_fusion_gun_key]
		
	# add the gun to the bosses inventory
	gun_keys.append(_fusion_gun_key)
	
	# set the offsets based on the first gun
	var first_gun_key: String = _component_gun_keys.get(0)
	_copy_gun_offsets(first_gun_key, _fusion_gun_key)
	
	if gun_keys.size() > 0:
		curr_gun_index = gun_keys.find(_fusion_gun_key)
		if curr_gun_index == -1:
			curr_gun_index = 0
		var _curr_gun_key: String = gun_keys[curr_gun_index]

		curr_gun = GunData.guns[_curr_gun_key]
		curr_projectile_spec = GunData.projectile_library[curr_gun.projectile_type]
		if curr_gun.projectile_type != "rocket":
			curr_projectile_spec.damage *= 2
		
		_update_gun_texture_for_boss()
		_update_projectile_spawn_position_for_boss()
	
	return _fusion_gun_key


func shoot() -> void:
	var _multiplier: float = curr_gun.dmg_multiplier 
	var _projectile_damage: float = curr_projectile_spec.damage
	var _damage: float = _projectile_damage * _multiplier
	var _base_direction: Vector2 = projectile_spawn.global_transform.x.normalized()
	var _gun_sound: AudioStream = curr_gun.shoot_sound
	
	for i in range(curr_gun.projectile_count):
		var _projectile: Projectile = projectile_factory.create_projectile(curr_projectile_spec, _damage)
		_projectile.global_position = projectile_spawn.global_position
		_projectile.rotation = projectile_spawn.global_rotation
		_projectile.npc_shot = true
		
		var _angle_offset: float = 0.0
		if curr_gun.projectile_count > 1:
			var step: float= curr_gun.spread_angle / (curr_gun.projectile_count - 1)
			_angle_offset = -curr_gun.spread_angle / 2.0 + (i * step)
		
		var _direction: Vector2 = _base_direction.rotated(deg_to_rad(_angle_offset))
		_projectile.linear_velocity = _direction * curr_gun.projectile_speed
		
		shooting_sound.stream = _gun_sound
		shooting_sound.play()
		self.get_tree().current_scene.add_child(_projectile)


# setup the gun depending on the enemy type
func setup_gun(gun_key: String):
	# set the gun keys to remember which gun we have
	gun_keys = [gun_key]
	
	# populate the gun based on the key
	curr_gun = GunData.guns[gun_key]
	curr_projectile_spec = GunData.projectile_library[base_weapon_to_projectile[gun_key]]
	
	# slow down machine gun enemy fire rate
	if gun_key == "machine gun":
		curr_gun.shot_delay = 0.3
	
	# set the gun sprite
	_set_gun_sprite()


func _ready() -> void:
	curr_projectile_spec = GunData.projectile_library["normal"]
	
	_player = get_tree().get_first_node_in_group("player")


func _process(_delta: float) -> void:
	if _player == null:
		return
	_time_since_last_shot += _delta
	var direction: Vector2 = (_player.global_position - global_position).normalized()
	
	if direction.x < 0:
		scale.x = -1  # Flip the gun vertically
		position.x = -abs(position.x)  # Move gun to the other side
	else:
		scale.x = 1  # Normal orientation
		position.x = abs(position.x)  # Move gun back to normal side
	
	rotation_pivot.look_at(_player.global_position)


func _create_fusion_gun_instance(fusion_gun_key: String) -> Gun:
	if not fusion_gun_classes.has(fusion_gun_key):
		return null
	var gun_class: GDScript = fusion_gun_classes[fusion_gun_key]
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


func _update_gun_texture_for_boss() -> void:
	var _curr_gun_key: String = gun_keys[curr_gun_index]
	
	if gun_textures.has(_curr_gun_key):
		gun_sprite.visible = true
		gun_sprite.texture = gun_textures[_curr_gun_key]
		gun_sprite.position = gun_sprite_positions[_curr_gun_key]
		
		if _curr_gun_key in boss_gun_offsets:
			gun_sprite.position += boss_gun_offsets[_curr_gun_key]
	else:
		push_error("Invalid gun index or gun_sprite not found: " + str(_curr_gun_key))


func _update_projectile_spawn_position_for_boss() -> void:
	var _curr_gun_key: String = gun_keys[curr_gun_index]
	
	if projectile_spawn and projectile_spawn_offsets.has(_curr_gun_key):
		projectile_spawn.position = projectile_spawn_offsets[_curr_gun_key]
		
		if _curr_gun_key in boss_projectile_spawn_offsets:
			projectile_spawn.position += boss_projectile_spawn_offsets[_curr_gun_key]
	else:
		push_error("Invalid gun index or projectile_spawn not found: " + str(_curr_gun_key))


func _set_gun_sprite() -> void:
	var _curr_gun_key: String = gun_keys[0]
	
	gun_sprite.texture = gun_textures[_curr_gun_key]
	gun_sprite.position = gun_sprite_positions[_curr_gun_key]
	
	gun_sprite.z_index = 50
	gun_sprite.z_as_relative = false
	
	gun_sprite.visible = true
	gun_sprite.position.x += basic_enemy_gun_offsets_x[_curr_gun_key]
