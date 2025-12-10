class_name RocketPistol
extends Gun


func _init() -> void:
	dmg_multiplier = 5
	projectile_speed = 500
	shot_delay = 0.75
	projectile_scale = Vector2(0.05, 0.05)
	firing_mode = FiringMode.SEMI_AUTO
	explosion_radius = 100.0
	projectile_type = "rocket"
	shoot_sound = preload("res://assets/sounds/rocket_launcher_sound.wav")
	magazine_size = 5
	starting_reserve = 15
	max_reserve = 30
	reload_time = 3.5
