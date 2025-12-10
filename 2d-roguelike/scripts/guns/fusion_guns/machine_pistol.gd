class_name MachinePistol
extends Gun


func _init() -> void:
	dmg_multiplier = 0.2
	projectile_speed = 1000
	shot_delay = 0.05
	projectile_scale = Vector2(0.0075, 0.0075)
	firing_mode = FiringMode.AUTO
	projectile_type = "normal"
	shoot_sound = preload("res://assets/sounds/machine_gun_sound.wav")
	magazine_size = 25
	starting_reserve = 200
	max_reserve = 400
	reload_time = 2.5
