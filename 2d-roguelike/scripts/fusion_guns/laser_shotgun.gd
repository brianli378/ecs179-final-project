class_name LaserShotgun
extends Gun


func _init() -> void:
	dmg_multiplier = 1.2
	projectile_speed = 1500
	shot_delay = 2.0
	projectile_scale = Vector2(0.02, 0.02)
	firing_mode = FiringMode.SEMI_AUTO
	projectile_count = 3
	spread_angle = 20.0
	projectile_type = "laser"
	shoot_sound = preload("res://assets/sounds/laser-sound.wav")
	magazine_size = 9999999
	starting_reserve = 0
	max_reserve = 0
	reload_time = 0.0
