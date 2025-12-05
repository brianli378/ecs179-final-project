class_name LaserPistol
extends Gun


func _init() -> void:
	dmg_multiplier = 1.5
	projectile_speed = 2000
	shot_delay = 0.9
	projectile_scale = Vector2(0.02, 0.02)
	firing_mode = FiringMode.SEMI_AUTO
	projectile_type = "laser"
	shoot_sound = preload("res://assets/sounds/laser-sound.wav")
	magazine_size = 99999999
	starting_reserve = 0
	max_reserve = 0
	reload_time = 0.0
