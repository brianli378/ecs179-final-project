class_name LaserMachineGun
extends Gun


func _init() -> void:
	dmg_multiplier = 0.1
	projectile_speed = 1200
	shot_delay = 0.1
	projectile_scale = Vector2(0.02, 0.02)
	firing_mode = FiringMode.AUTO
	projectile_type = "laser"
	shoot_sound = preload("res://assets/sounds/laser-sound.wav")
	magazine_size = 9999999
	starting_reserve = 0
	max_reserve = 0
	reload_time = 0.0
