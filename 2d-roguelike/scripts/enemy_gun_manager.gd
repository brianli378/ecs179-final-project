class_name EnemyGunManager
extends Node2D

# Load the projectile types
var projectile_library = {
	"normal": preload("res://specs/projectiles/normal_projectile.tres"),
	"laser":  preload("res://specs/projectiles/laser_projectile.tres"),
	"rocket": preload("res://specs/projectiles/rocket_projectile.tres")
}

var curr_projectile_spec: ProjectileSpec = projectile_library["normal"]

var _time_since_last_shot: float = 0.0
var curr_gun: Gun = null

var facing_right = false
var default_state = true

var guns: Dictionary = {
	"pistol": Pistol.new(),
	"machine gun": MachineGun.new(),
	"sniper": Sniper.new(),
	"shotgun": Shotgun.new(),
	"rocket launcher": RocketLauncher.new()
}
	
var gun_keys: Array[String] = ["pistol", "machine gun", "shotgun", "rocket launcher"] # Array for easy indexing
var curr_gun_index: int = 0  # Index into gun_keys array

# ammo variables
var ammo_in_mag: Dictionary = {}
var ammo_in_reserve: Dictionary = {}
var is_reloading: bool = false

var default_gun_texture: Texture2D = preload("res://assets/placeholder_gun.svg")

var gun_sprite: Sprite2D

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
	"pachine gun": preload("res://assets/guns/pachine_gun_sprite.png"),
	
	# shotgun fusions
	"shistol": preload("res://assets/guns/shistol_sprite.png"),
	"shocket launcher": preload("res://assets/guns/shocket_launcher_sprite.png"),
	"shiper": preload("res://assets/guns/shiper_sprite.png"),
	"shachine gun": preload("res://assets/guns/shachine_gun_sprite.png"),
	
	# rocket launcher fusions
	"rocket pistol": preload("res://assets/guns/rocket_pistol_sprite.png"),
	"rocket shotgun":  preload("res://assets/guns/rocket_shotgun_sprite.png"),
	"rocket sniper":  preload("res://assets/guns/rocket_sniper_sprite.png"),
	"rockchine gun":  preload("res://assets/guns/rockchine_gun_sprite.png"),
	
	# sniper fusions
	"laser pistol": preload("res://assets/guns/laser_pistol_sprite.png"),
	"laser shotgun": preload("res://assets/guns/laser_shotgun_sprite.png"),
	"laser rocket launcher": preload("res://assets/guns/laser_rocket_launcher_sprite.png"),
	"laser machine gun": preload("res://assets/guns/laser_machinegun_sprite.png"),
	
	# machine gun fusions
	"machine pistol": preload("res://assets/guns/machine_pistol_sprite.png"), 
	"machinegungun": preload("res://assets/guns/machinegun_gun_sprite.png"), 
	"machine launcher": preload("res://assets/guns/machine_launcher_sprite.png"), 
	"machineper": preload("res://assets/guns/machine_per_sprite.png")
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

@onready
var _gun_manager: EnemyGunManager = $BossEnemy/Body/EnemyGunManager

@onready
var _enemy_char: CharacterBody2D = $BossEnemy

@onready 
var shooting_sound: AudioStreamPlayer2D = $shooting_sound

@onready
var line_of_sight : EnemyLineOfSight = $EnemyLineOfSight

@onready 
var projectile_spawn: Node2D = $RotationPivot/ProjectileSpawn

@onready 
var _player:Player

@onready 
var enemy = get_parent().get_parent()

@onready 
var rotation_pivot: Node2D = $RotationPivot

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
	

func fuse_guns() -> String:
	var first_gun_key: String = gun_keys.pick_random()
	var second_gun_key: String = gun_keys.pick_random()
	while first_gun_key == second_gun_key:
		second_gun_key = gun_keys.pick_random()
	
	var recipe_key: String = first_gun_key + "+" + second_gun_key

	var fusion_gun_key: String = fusion_recipes[recipe_key]
	var fusion_gun_instance: Gun = _create_fusion_gun_instance(fusion_gun_key)
	if fusion_gun_instance == null:
		return ""

	var first_index: int = gun_keys.find(first_gun_key)
	if first_index != -1:
		gun_keys.remove_at(first_index)

	var second_index: int = gun_keys.find(second_gun_key)
	if second_index != -1:
		gun_keys.remove_at(second_index)

	guns[fusion_gun_key] = fusion_gun_instance
	gun_keys.append(fusion_gun_key)

	_copy_gun_offsets(first_gun_key, fusion_gun_key)

	if gun_keys.size() > 0:
		curr_gun_index = gun_keys.find(fusion_gun_key)
		if curr_gun_index == -1:
			curr_gun_index = 0
		var curr_gun_key: String = gun_keys[curr_gun_index]
		curr_gun = guns[curr_gun_key]
		curr_projectile_spec = projectile_library[curr_gun.projectile_type]
		print("updating gun texture")
		_update_gun_texture()
		_update_projectile_spawn_position()

	return fusion_gun_key
	


func _update_gun_texture() -> void:
	var curr_gun_key = gun_keys[curr_gun_index]
	
	if gun_textures.has(curr_gun_key):
		print("setting gun sprite")
		print(curr_gun_key)
		gun_sprite.texture = gun_textures[curr_gun_key]
		gun_sprite.position = gun_sprite_positions[curr_gun_key]
		print("done")
	else:
		push_error("Invalid gun index or gun_sprite not found: " + str(curr_gun_key))
		

func _update_projectile_spawn_position() -> void:
	var curr_gun_key = gun_keys[curr_gun_index]
	
	if projectile_spawn and projectile_spawn_offsets.has(curr_gun_key):
		projectile_spawn.position = projectile_spawn_offsets[curr_gun_key]
	else:
		push_error("Invalid gun index or projectile_spawn not found: " + str(curr_gun_key))


func _ready() -> void:
	_player = get_tree().get_first_node_in_group("player")
	
	_set_gun_sprite()

func _set_gun_sprite() -> void:
	var parent : Node = get_parent().get_parent().get_parent()
	gun_sprite = Sprite2D.new()
		
	gun_sprite.z_index = 50
	gun_sprite.z_as_relative = false

	
	gun_sprite.visible = true
	gun_sprite.position.x -= 80
	
	get_child(0).add_child(gun_sprite)


func _process(_delta: float) -> void:
	if _player == null:
		return
	_time_since_last_shot += _delta
	var direction: Vector2 = (_player.global_position - global_position).normalized()
	#look_at()

	if direction.x < 0:
		scale.x = -1  # Flip the gun vertically
		position.x = -abs(position.x)  # Move gun to the other side
	else:
		scale.x = 1  # Normal orientation
		position.x = abs(position.x)  # Move gun back to normal side

	rotation_pivot.look_at(_player.global_position)

func shoot() -> void:
	var multiplier = curr_gun.dmg_multiplier 
	var projectile_damage = curr_projectile_spec.damage
	var damage = projectile_damage * multiplier
	var base_direction: Vector2 = projectile_spawn.global_transform.x.normalized()
	var gun_sound = curr_gun.shoot_sound

	for i in range(curr_gun.projectile_count):
		var projectile = projectile_factory.create_projectile(curr_projectile_spec, damage)
		projectile.global_position = projectile_spawn.global_position
		projectile.rotation = projectile_spawn.global_rotation
		projectile.npc_shot = true
		
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
