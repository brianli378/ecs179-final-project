class_name Pistol
extends Gun


func _init() -> void:
	dmg_multiplier = 1
	projectile_speed = 1200
	shot_delay = 0.75
	projectile_scale = Vector2(0.01, 0.01)
	firing_mode = FiringMode.SEMI_AUTO
	projectile_type = "normal"
	shoot_sound = preload("res://assets/sounds/pistol_sound.wav")
	magazine_size = 15
	starting_reserve = 50
	max_reserve = 100
	reload_time = 0.5
