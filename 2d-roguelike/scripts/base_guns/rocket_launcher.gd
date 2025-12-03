class_name RocketLauncher
extends Gun


func _init() -> void:
	dmg_multiplier = 3
	projectile_speed = 500
	shot_delay = 5.0
	projectile_scale = Vector2(0.05, 0.05)
	firing_mode = FiringMode.SEMI_AUTO
	explosion_radius = 200.0
	projectile_type = "rocket"
	shoot_sound = preload("res://assets/sounds/rocket_launcher_sound.wav")
