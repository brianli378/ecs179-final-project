class_name ProjectileFactory
extends Node

var projectile_scene = preload("res://scenes/projectile.tscn")

func create_projectile(spec: ProjectileSpec, final_damage: float) ->  Projectile:
	var projectile = projectile_scene.instantiate()
	projectile.initialize(spec, final_damage)
	return projectile
