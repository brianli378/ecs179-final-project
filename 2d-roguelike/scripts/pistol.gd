class_name Pistol
extends Gun


func _init() -> void:
	damage = 10
	projectile_speed = 1200
	shot_delay = 1.0
	projectile_scale = Vector2(0.01, 0.01)
	firing_mode = FiringMode.SEMI_AUTO
