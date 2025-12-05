class_name Potgun
extends Gun

func _init() -> void:
	reload_time = 0.5
	projectile_count = 4
	spread_angle = 20.0
	magazine_size = 8
	
	dmg_multiplier = 1
	projectile_speed = 1200
	shot_delay = 0.5
	projectile_scale = Vector2(0.01, 0.01)
	firing_mode = FiringMode.SEMI_AUTO
	projectile_type = "normal"
	shoot_sound = preload("res://assets/sounds/shotgun_sound.wav")
	starting_reserve = 50
	max_reserve = 100
