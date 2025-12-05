class_name RocketShotgun
extends Gun


func _init() -> void:
	dmg_multiplier = 2.5
	projectile_speed = 500
	shot_delay = 3.0
	projectile_scale = Vector2(0.05, 0.05)
	firing_mode = FiringMode.SEMI_AUTO
	explosion_radius = 50.0
	projectile_count = 6
	spread_angle = 60.0
	projectile_type = "rocket"
	shoot_sound = preload("res://assets/sounds/rocket_launcher_sound.wav")
	magazine_size = 1
	starting_reserve = 5
	max_reserve = 10
	reload_time = 3.0
