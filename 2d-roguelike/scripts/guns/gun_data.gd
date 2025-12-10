# res://scripts/gun_data.gd
class_name GunData
extends Resource

const projectile_library = {
	"normal": preload("res://specs/projectiles/normal_projectile.tres"),
	"laser":  preload("res://specs/projectiles/laser_projectile.tres"),
	"rocket": preload("res://specs/projectiles/rocket_projectile.tres")
}

# Base gun textures
const gun_textures: Dictionary = {
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
	"machinegun gun": preload("res://assets/guns/machinegun_gun_sprite.png"), 
	"machine launcher": preload("res://assets/guns/machine_launcher_sprite.png"), 
	"machineper": preload("res://assets/guns/machine_per_sprite.png")
}

const gun_offsets_right: Dictionary = {
	"pistol": Vector2(-90, 20),
	"machine gun": Vector2(-40, 25),
	"sniper": Vector2(0, 0),
	"shotgun": Vector2(0, 0), 
	"rocket launcher": Vector2(0, 0),
	
	# pistol fusions
	"potgun": Vector2(-90, 20),
	"pocket launcher": Vector2(0, 0),
	"piper": Vector2(0, 0),
	"pachine gun": Vector2(-90, 20),
	
	# shotgun fusions
	"shistol": Vector2(-60, 20),
	"shocket launcher": Vector2(0, 0),
	"shiper": Vector2(0, 0),
	"shachine gun": Vector2(0, 0),
	
	# rocket launcher fusions
	"rocket pistol": Vector2(-90, 20),
	"rocket shotgun": Vector2(0, 0),
	"rocket sniper": Vector2(0, 0),
	"rockchine gun": Vector2(-40, 25),
	
	# sniper fusions
	"laser pistol": Vector2(-90, 20),
	"laser shotgun": Vector2(0, 0),
	"laser rocket launcher": Vector2(0, 0),
	"laser machine gun": Vector2(0, 0),
	
	# machine gun fusions
	"machine pistol": Vector2(-40, 20),
	"machinegun gun": Vector2(-40, 25),
	"machine launcher": Vector2(-40, 25),
	"machineper": Vector2(0, 0),
}

const gun_offsets_left: Dictionary = {
	"pistol": Vector2(90, 20),
	"machine gun": Vector2(40, 25),
	"sniper": Vector2(0, 0),
	"shotgun": Vector2(0, 0), 
	"rocket launcher": Vector2(0, 0),
	
	# pistol fusions
	"potgun": Vector2(90, 20),
	"pocket launcher": Vector2(90, 20),
	"piper": Vector2(90, 20),
	"pachine gun": Vector2(90, 20),
	
	# shotgun fusions
	"shistol": Vector2(60, 20),
	"shocket launcher": Vector2(0, 0),
	"shiper": Vector2(0, 0),
	"shachine gun": Vector2(0, 0),
	
	# rocket launcher fusions
	"rocket pistol":  Vector2(90, 20),
	"rocket shotgun": Vector2(0, 0),
	"rocket sniper": Vector2(0, 0),
	"rockchine gun": Vector2(40, 25),
	
	# sniper fusions
	"laser pistol": Vector2(90, 20),
	"laser shotgun": Vector2(0, 0),
	"laser rocket launcher": Vector2(0, 0),
	"laser machine gun": Vector2(0, 0),
	
	# machine gun fusions
	"machine pistol": Vector2(40, 20),
	"machinegun gun": Vector2(40, 25),
	"machine launcher": Vector2(40, 25),
	"machineper": Vector2(0, 0),
}

const gun_sprite_positions: Dictionary = {
	"pistol": Vector2(-20, 0),
	"machine gun": Vector2(-175, 0),
	"sniper": Vector2(-200, 0),
	"shotgun": Vector2(0, 0), 
	"rocket launcher": Vector2(-200, -60),
	
	# pistol fusions
	"potgun": Vector2(0, 0),
	"pocket launcher": Vector2(0, 0),
	"piper": Vector2(0, 0),
	"pachine gun": Vector2(0, 0),
	
	# shotgun fusions
	"shistol": Vector2(-20, 0),
	"shocket launcher": Vector2(0, 0),
	"shiper": Vector2(0, 0),
	"shachine gun": Vector2(0, 0),
	
	# rocket launcher fusions
	"rocket pistol": Vector2(-20, 0),
	"rocket shotgun": Vector2(0, 0),
	"rocket sniper": Vector2(-200, 0),
	"rockchine gun": Vector2(-175, 0),
	
	# sniper fusions
	"laser pistol": Vector2(0, 0),
	"laser shotgun": Vector2(0, 0),
	"laser rocket launcher": Vector2(-200, -30),
	"laser machine gun": Vector2(0, 0),
	
	# machine gun fusions
	"machine pistol": Vector2(-100, 0),
	"machinegun gun": Vector2(-175, 0),
	"machine launcher": Vector2(-175, 0),
	"machineper": Vector2(-200, 0),
}

const basic_enemy_gun_offsets_x: Dictionary = {
	"rocket launcher": 120,
	"sniper": 120,
	"machine gun": 120,
	"pistol": -10,
	"shotgun": 0,
}

const base_weapon_to_projectile: Dictionary = {
	"rocket launcher": "rocket",
	"sniper": "laser",
	"machine gun": "normal",
	"pistol": "normal",
	"shotgun": "normal",
}

const projectile_spawn_offsets: Dictionary = {
	"pistol": Vector2(200, 0),
	"machine gun": Vector2(220, 20),
	"sniper": Vector2(430, 20),
	"shotgun": Vector2(250, 0), 
	"rocket launcher": Vector2(250, 25),
	
	# pistol fusions
	"potgun": Vector2(200, 0),
	"pocket launcher": Vector2(200, 0),
	"piper": Vector2(200, 0),
	"pachine gun": Vector2(200, 0),
	
	# shotgun fusions
	"shistol": Vector2(200, 0),
	"shocket launcher": Vector2(200, 0),
	"shiper": Vector2(200, 0),
	"shachine gun": Vector2(200, 0),
	
	# rocket launcher fusions
	"rocket pistol": Vector2(200, 0),
	"rocket shotgun": Vector2(200, 0),
	"rocket sniper": Vector2(430, 20),
	"rockchine gun": Vector2(200, 0),
	
	# sniper fusions
	"laser pistol": Vector2(200, 0),
	"laser shotgun": Vector2(200, 0),
	"laser rocket launcher": Vector2(250, 25),
	"laser machine gun": Vector2(200, 0),
	
	# machine gun fusions
	"machine pistol": Vector2(200, 0),
	"machinegun gun": Vector2(220, 20),
	"machine launcher": Vector2(220, 20),
	"machineper": Vector2(220, 0),
}

# Fusion recipes
const fusion_recipes: Dictionary = {
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

static var fusion_gun_classes: Dictionary = {
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

static var guns: Dictionary = {
	"pistol": Pistol.new(),
	"machine gun": MachineGun.new(),
	"sniper": Sniper.new(),
	"shotgun": Shotgun.new(),
	"rocket launcher": RocketLauncher.new()
}
