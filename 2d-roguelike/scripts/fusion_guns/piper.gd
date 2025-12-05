class_name Piper
extends Gun


func _init() -> void:
	dmg_multiplier = 1.8
	projectile_speed = 1800
	shot_delay = 0.75
	projectile_scale = Vector2(0.02, 0.02)
	firing_mode = FiringMode.SEMI_AUTO
	projectile_type = "laser"
	shoot_sound = preload("res://assets/sounds/laser-sound.wav")
	magazine_size = 8
	starting_reserve = 35
	max_reserve = 50
	reload_time = 0.5
