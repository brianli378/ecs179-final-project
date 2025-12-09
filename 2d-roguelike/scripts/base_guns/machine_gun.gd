class_name MachineGun
extends Gun


func _init() -> void:
	dmg_multiplier = 2.0
	projectile_speed = 1300
	shot_delay = 0.1
	projectile_scale = Vector2(0.0075, 0.0075)
	firing_mode = FiringMode.AUTO
	projectile_type = "normal"
	shoot_sound = preload("res://assets/sounds/machine_gun_sound.wav")
	magazine_size = 75
	starting_reserve = 150
	max_reserve = 300
	reload_time = 2.0
