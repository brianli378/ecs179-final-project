class_name Sniper
extends Gun


func _init() -> void:
	dmg_multiplier = 2
	projectile_speed = 2000
	shot_delay = 2.0
	projectile_scale = Vector2(0.02, 0.02)
	firing_mode = FiringMode.SEMI_AUTO
	projectile_type = "laser"
	shoot_sound = preload("res://assets/sounds/sniper_sound.wav")
