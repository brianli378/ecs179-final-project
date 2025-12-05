class_name Shistol
extends Gun


func _init() -> void:
	dmg_multiplier = 0.6
	projectile_speed = 1000
	shot_delay = 0.9
	projectile_scale = Vector2(0.005, 0.005)
	firing_mode = FiringMode.SEMI_AUTO
	projectile_count = 6
	spread_angle = 20.0
	projectile_type = "normal"
	shoot_sound = preload("res://assets/sounds/shotgun_sound.wav")
	magazine_size = 6
	starting_reserve = 36
	max_reserve = 72
	reload_time = 0.9
