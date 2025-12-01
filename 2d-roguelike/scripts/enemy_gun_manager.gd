class_name EnemyGunManager
extends Node2D

@onready var projectile_spawn: Node2D = $ProjectileSpawn

var _projectile_scene = preload("res://scenes/projectile.tscn")
var _time_since_last_shot: float = 0.0

var curr_gun: Gun = null

# we don't want to read inputs if the gun manager belongs to an npc
var npc: bool = false

func _process(_delta: float) -> void:
	_time_since_last_shot += _delta


func shoot() -> void:
	var projectile: Projectile = _projectile_scene.instantiate()
	projectile.global_position = projectile_spawn.global_position
	projectile.npc_shot = true
	
	var direction: Vector2 = projectile_spawn.global_transform.x.normalized()
	projectile.linear_velocity = direction * curr_gun.projectile_speed
	
	for child in projectile.get_children():
		child.scale = curr_gun.projectile_scale
	
	self.get_tree().current_scene.add_child(projectile)
