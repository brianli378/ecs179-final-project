class_name PocketLauncher
extends Gun


func _init() -> void:
	dmg_multiplier = 10
	projectile_speed = 650
	shot_delay = 1.0
	projectile_scale = Vector2(0.05, 0.05)
	firing_mode = FiringMode.SEMI_AUTO
	projectile_type = "rocket"
	explosion_radius = 200.0
	shoot_sound = preload("res://assets/sounds/rocket_launcher_sound.wav")
	magazine_size = 1
	starting_reserve = 5
	max_reserve = 10
	reload_time = 1.0
