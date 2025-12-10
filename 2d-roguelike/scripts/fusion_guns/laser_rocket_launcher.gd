class_name LaserRocketLauncher
extends LaserGun

var beam_active: bool = false
var heat_per_second: float = 40.0  # continuous heat buildup

func _init() -> void:
	super._init()
	dmg_multiplier = 0.1
	projectile_speed = 2000
	shot_delay = 0.05  # fires continuously when held
	projectile_scale = Vector2(0.15, 0.15)
	firing_mode = FiringMode.AUTO
	projectile_count = 1
	spread_angle = 0.0
	shoot_sound = preload("res://assets/sounds/laser-sound.wav")
	
	# Overheat properties
	max_heat = 100.0
	heat_per_shot = 7.0  # low per shot since it fires rapidly
	cooling_rate = 40.0
	base_spread = 0.0
	max_heat_spread = 5.0
