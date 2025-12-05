class_name ShocketLauncher
extends Gun


func _init() -> void:
	dmg_multiplier = 5
	projectile_speed = 500
	shot_delay = 2.2
	projectile_scale = Vector2(0.05, 0.05)
	firing_mode = FiringMode.SEMI_AUTO
	explosion_radius = 100.0
	projectile_count = 3
	spread_angle = 30.0
	projectile_type = "rocket"
	shoot_sound = preload("res://assets/sounds/rocket_launcher_sound.wav")
	magazine_size = 1
	starting_reserve = 5
	max_reserve = 10
	reload_time = 2.2
