class_name MachineLauncher
extends Gun


func _init() -> void:
	dmg_multiplier = 2.5
	projectile_speed = 1000
	shot_delay = 0.2
	projectile_scale = Vector2(0.05, 0.05)
	firing_mode = FiringMode.AUTO
	explosion_radius = 50.0
	projectile_type = "rocket"
	shoot_sound = preload("res://assets/sounds/rocket_launcher_sound.wav")
	magazine_size = 20
	starting_reserve = 80
	max_reserve = 160
	reload_time = 4.0
