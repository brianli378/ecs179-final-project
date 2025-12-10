class_name MachineGunGun
extends Gun


func _init() -> void:
	dmg_multiplier = 0.2
	projectile_speed = 1000
	shot_delay = 0.2
	projectile_scale = Vector2(0.0075, 0.0075)
	firing_mode = FiringMode.AUTO
	projectile_type = "normal"
	projectile_count = 4
	spread_angle = 24.0
	shoot_sound = preload("res://assets/sounds/machine_gun_sound.wav")
	magazine_size = 30
	starting_reserve = 120
	max_reserve = 360
	reload_time = 3.5
