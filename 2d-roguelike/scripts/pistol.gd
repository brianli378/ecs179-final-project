class_name Pistol
extends Gun


func _init() -> void:
	damage = 10
	projectile_speed = 1000
	shot_delay = 1.0


func _on_projectile_spawned(projectile: Projectile) -> void:
	projectile.scale = Vector2.ONE
