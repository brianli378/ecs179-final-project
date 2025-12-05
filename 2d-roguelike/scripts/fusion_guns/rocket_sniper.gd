class_name RocketSniper
extends Gun


func _init() -> void:
	dmg_multiplier = 15
	projectile_speed = 2000
	shot_delay = 3.0
	projectile_scale = Vector2(0.05, 0.05)
	firing_mode = FiringMode.SEMI_AUTO
	explosion_radius = 200.0
	projectile_type = "rocket"
	shoot_sound = preload("res://assets/sounds/laser-sound.wav")
	magazine_size = 1
	starting_reserve = 5
	max_reserve = 10
	reload_time = 3.0
