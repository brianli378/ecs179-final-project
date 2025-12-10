class_name LaserPistol
extends LaserGun

func _init() -> void:
	super._init()
	dmg_multiplier = 1.2
	projectile_speed = 1500
	shot_delay = 0.35
	projectile_scale = Vector2(0.05, 0.05)
	firing_mode = FiringMode.SEMI_AUTO
	projectile_count = 1
	spread_angle = 2.0
	shoot_sound = preload("res://assets/sounds/laser-sound.wav")
	
	# Overheat properties
	max_heat = 100.0
	heat_per_shot = 15.0
	cooling_rate = 25.0
	base_spread = 2.0
	max_heat_spread = 8.0
