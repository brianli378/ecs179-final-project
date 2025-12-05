class_name ShachineGun
extends Gun


func _init() -> void:
	dmg_multiplier = 0.5
	projectile_speed = 1000
	shot_delay = 1.5
	projectile_scale = Vector2(0.01, 0.01)
	firing_mode = FiringMode.AUTO
	projectile_count = 15
	spread_angle = 60.0
	projectile_type = "normal"
	shoot_sound = preload("res://assets/sounds/shotgun_sound.wav")
	magazine_size = 6
	starting_reserve = 30
	max_reserve = 60
	reload_time = 2.0
