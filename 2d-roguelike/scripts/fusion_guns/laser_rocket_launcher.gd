class_name LaserRocketLauncher
extends Gun


func _init() -> void:
	dmg_multiplier = 20
	projectile_speed = 500
	shot_delay = 3.0
	projectile_scale = Vector2(0.02, 0.02)
	firing_mode = FiringMode.SEMI_AUTO
	explosion_radius = 500.0
	projectile_type = "laser"
	shoot_sound = preload("res://assets/sounds/laser-sound.wav")
	magazine_size = 1
	starting_reserve = 3
	max_reserve = 6
	reload_time = 3.0
