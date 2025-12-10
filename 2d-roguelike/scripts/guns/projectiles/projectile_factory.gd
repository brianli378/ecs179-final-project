class_name ProjectileFactory
extends Node

var projectile_scene = preload("res://scenes/projectile.tscn")
var rocket_projectile_scene = preload("res://scenes/rocket_projectile.tscn")

func create_projectile(spec: ProjectileSpec, final_damage: float) ->  Projectile:
	var projectile: Projectile
	if spec.type == ProjectileSpec.ProjectileType.ROCKET:
		projectile = rocket_projectile_scene.instantiate()
	#elif spec.type == ProjectileSpec.ProjectileType.NORMAL:
		#projectile = projectile_scene.instantiate()
	else:
		projectile = projectile_scene.instantiate()
		
	projectile.initialize(spec, final_damage)
	return projectile
