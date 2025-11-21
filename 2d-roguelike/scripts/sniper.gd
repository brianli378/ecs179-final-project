class_name Sniper
extends Gun


func _init() -> void:
	damage = 40
	projectile_speed = 1000
	shot_delay = 3.0
	

func _on_projectile_spawned(projectile: Projectile) -> void:
	projectile.scale = Vector2(1.5, 1.5)
