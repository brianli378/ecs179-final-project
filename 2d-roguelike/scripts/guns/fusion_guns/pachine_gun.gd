class_name PachineGun
extends Gun


func _init() -> void:
	dmg_multiplier = 1
	projectile_speed = 1000
	shot_delay = 0.1
	projectile_scale = Vector2(0.0075, 0.0075)
	firing_mode = FiringMode.AUTO
	projectile_type = "normal"
	shoot_sound = preload("res://assets/sounds/pistol_sound.wav")
	magazine_size = 20
	starting_reserve = 100
	max_reserve = 250
	reload_time = 1.0
