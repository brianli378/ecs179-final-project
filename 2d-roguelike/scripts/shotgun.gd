class_name Shotgun
extends Gun

func _init() -> void:
	damage = 5
	projectile_speed = 1000
	shot_delay = 1.5
	projectile_scale = Vector2(0.01, 0.01)
	firing_mode = FiringMode.SEMI_AUTO
	projectile_count = 5
	spread_angle = 30.0
