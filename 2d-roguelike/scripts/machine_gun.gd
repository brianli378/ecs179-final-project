class_name MachineGun
extends Gun


func _init() -> void:
	damage = 5
	projectile_speed = 1000
	shot_delay = 0.5


func _on_projectile_spawned(projectile: Projectile) -> void:
	projectile.scale = Vector2(0.5, 0.5)
