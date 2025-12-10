class_name Machineper
extends Gun


func _init() -> void:
	dmg_multiplier = 1
	projectile_speed = 1500
	shot_delay = 0.3
	projectile_scale = Vector2(0.0075, 0.0075)
	firing_mode = FiringMode.AUTO
	projectile_type = "normal"
	shoot_sound = preload("res://assets/sounds/machine_gun_sound.wav")
	magazine_size = 25
	starting_reserve = 100
	max_reserve = 200
	reload_time = 3.5
