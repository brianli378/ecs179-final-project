class_name Shiper
extends Gun


func _init() -> void:
	dmg_multiplier = 1
	projectile_speed = 1500
	shot_delay = 1.5
	projectile_scale = Vector2(0.02, 0.02)
	firing_mode = FiringMode.SEMI_AUTO
	projectile_count = 5
	spread_angle = 20.0
	projectile_type = "laser"
	shoot_sound = preload("res://assets/sounds/laser-sound.wav")
	magazine_size = 1
	starting_reserve = 15
	max_reserve = 30
	reload_time = 1.5
