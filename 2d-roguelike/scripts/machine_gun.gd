class_name MachineGun
extends Gun


func _init() -> void:
	damage = 2.5
	projectile_speed = 1000
	shot_delay = 0.1
	projectile_scale = Vector2(0.0075, 0.0075)
	firing_mode = FiringMode.AUTO
