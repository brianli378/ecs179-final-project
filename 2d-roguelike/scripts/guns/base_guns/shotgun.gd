class_name Shotgun
extends Gun

func _init() -> void:
	dmg_multiplier = 2.0
	projectile_speed = 1000
	shot_delay = 1.5
	projectile_scale = Vector2(0.01, 0.01)
	firing_mode = FiringMode.SEMI_AUTO
	projectile_count = 5
	spread_angle = 30.0
	projectile_type = "normal"
	shoot_sound = preload("res://assets/sounds/shotgun_sound.wav")
	magazine_size = 8
	starting_reserve = 30
	max_reserve = 60
	reload_time = 2.0
