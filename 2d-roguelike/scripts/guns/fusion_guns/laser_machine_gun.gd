class_name LaserMachineGun
extends LaserGun

func _init() -> void:
	super._init()
	dmg_multiplier = 0.6
	projectile_speed = 1200
	shot_delay = 0.1
	base_shot_delay = 0.1
	min_shot_delay = 0.05
	projectile_scale = Vector2(0.03, 0.03)
	firing_mode = FiringMode.AUTO
	projectile_count = 1
	spread_angle = 3.0
	shoot_sound = preload("res://assets/sounds/laser-sound.wav")
	
	# Overheat properties
	max_heat = 100.0
	heat_per_shot = 5.0
	cooling_rate = 15.0
	base_spread = 3.0
	max_heat_spread = 20.0
	scales_fire_rate_with_heat = true  # Fire rate increases with heat!
